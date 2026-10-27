from pathlib import Path
import sys,json
from docx import Document
from docx.shared import Inches,Pt,RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.text import WD_LINE_SPACING
from docx.enum.table import WD_TABLE_ALIGNMENT,WD_CELL_VERTICAL_ALIGNMENT
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.opc.constants import RELATIONSHIP_TYPE as RT
from PIL import Image,ImageDraw,ImageFont

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'source'))
from design_data import MODULES
from chapters import compose
checks=json.loads((ROOT/'qa'/'balance-check.json').read_text())

def font(size,bold=False):
    names=['/System/Library/Fonts/Supplemental/Arial Bold.ttf' if bold else '/System/Library/Fonts/Supplemental/Arial.ttf', '/System/Library/Fonts/Helvetica.ttc']
    for n in names:
        if Path(n).exists():return ImageFont.truetype(n,size)
    return ImageFont.load_default(size=size)

def make_layout():
    b=checks['builds'][0]
    art=Image.new('RGB',(1600,820),'#FFFFFF');g=ImageDraw.Draw(art)
    g.text((48,25),'CONDUCTIVE CHAIN  /  VALIDATED LAYOUT',font=font(35,True),fill='#17232D')
    left,top,cell=70,140,118
    for c in range(5):g.text((left+c*cell+46,top-40),chr(65+c),font=font(23),fill='#58636B')
    for y in range(5):
        g.text((left-35,top+y*cell+42),str(y+1),font=font(23),fill='#58636B')
        for x in range(5):g.rectangle((left+x*cell,top+y*cell,left+(x+1)*cell,top+(y+1)*cell),fill='#F7F7F5',outline='#CCD2D6',width=2)
    cols={'W':'#EDD7BF','S':'#C6E7E1','U':'#DDE2E5'}
    centers={}
    for key,item in b['layout'].items():
        cells=item['cells']; mid=item['module']
        for x,y in cells:g.rectangle((left+x*cell+5,top+y*cell+5,left+(x+1)*cell-5,top+(y+1)*cell-5),fill=cols[mid[0]])
        cx=sum(x+.5 for x,y in cells)/len(cells)*cell+left
        cy=sum(y+.5 for x,y in cells)/len(cells)*cell+top
        centers[key]=(cx,cy)
        x,y=min(cells,key=lambda p:(p[1],p[0]))
        g.text((left+x*cell+18,top+y*cell+39),mid,font=font(25,True),fill='#17232D')
    for a,z in [('d','b'),('e','b'),('i','c')]:
        # Route a link between the closest centers of touching cells.
        pairs=[(c1,c2) for c1 in b['layout'][a]['cells'] for c2 in b['layout'][z]['cells'] if abs(c1[0]-c2[0])+abs(c1[1]-c2[1])==1]
        c1,c2=pairs[0]
        p1=(left+(c1[0]+.5)*cell,top+(c1[1]+.5)*cell+30)
        p2=(left+(c2[0]+.5)*cell,top+(c2[1]+.5)*cell+30)
        g.line((p1,p2),fill='#147F75',width=7)
        for x,y in [p1,p2]:g.ellipse((x-7,y-7,x+7,y+7),fill='#147F75')
    g.text((735,140),'18 / 25 CELLS',font=font(36,True),fill='#17232D')
    g.text((735,194),'13 / 17 POWER',font=font(36,True),fill='#17232D')
    entries=[('W01','Rivet gun'),('W03','Water gun'),('W04','Arc coil'),('S01','Damage amplifier'),('S02','Rapid-fire gear'),('S05','Conductive contact'),('U01','Power battery II'),('U02','Shield generator'),('U09','Recovery protocol')]
    for i,(mid,label) in enumerate(entries):
        y=280+i*47
        g.rectangle((735,y,765,y+30),fill=cols[mid[0]])
        g.text((783,y),mid+'  '+label,font=font(26),fill='#25333D')
    g.text((735,735),'Act III base power 14 + battery II bonus 3',font=font(22),fill='#58636B')
    art.save(ROOT/'assets'/'loadout.png')

def setfont(run,size=None,bold=None,color='000000'):
    run.font.name='Arial Unicode MS'
    run._element.get_or_add_rPr().get_or_add_rFonts().set(qn('w:eastAsia'),'Arial Unicode MS')
    if size:run.font.size=Pt(size)
    if bold is not None:run.font.bold=bold
    run.font.color.rgb=RGBColor.from_string(color)

class Writer:
    def __init__(self):
        self.doc=Document();self.break_pending=False;sec=self.doc.sections[0]
        sec.page_width=Inches(8.5);sec.page_height=Inches(11)
        sec.left_margin=sec.right_margin=Inches(.8)
        sec.top_margin=Inches(.65);sec.bottom_margin=Inches(.65)
        sec.header_distance=sec.footer_distance=Inches(.3)
        for name in ['Normal','Title','Subtitle','Heading 1','Heading 2','Caption','Header','Footer']:
            st=self.doc.styles[name];st.font.name='Arial Unicode MS';st.font.color.rgb=RGBColor(0,0,0)
            rf=st._element.get_or_add_rPr().get_or_add_rFonts()
            for attr in list(rf.attrib):
                if attr.endswith('Theme'):del rf.attrib[attr]
            rf.set(qn('w:eastAsia'),'Arial Unicode MS')
        for border in self.doc.styles.element.xpath('.//w:pBdr'):
            border.getparent().remove(border)
        n=self.doc.styles['Normal'];n.font.size=Pt(11)
        n.paragraph_format.line_spacing=Pt(15.5);n.paragraph_format.line_spacing_rule=WD_LINE_SPACING.EXACTLY;n.paragraph_format.space_after=Pt(6)
        n.paragraph_format.widow_control=True
        for name,size in [('Title',26),('Heading 1',19),('Heading 2',13.5)]:
            s=self.doc.styles[name];s.font.size=Pt(size);s.font.bold=True
            s.paragraph_format.space_before=Pt(12 if name=='Heading 2' else 0)
            s.paragraph_format.space_after=Pt(9)
            s.paragraph_format.keep_with_next=True
        self.doc.styles['Caption'].font.size=Pt(9)
        self.doc.styles['Caption'].font.italic=False
        self.doc.styles['Caption'].font.bold=False
        hp=sec.header.paragraphs[0];hp.text='背包机甲  游戏设计基线  v0.1'
        for r in hp.runs:setfont(r,8.5,color='000000')
        fp=sec.footer.paragraphs[0];fp.alignment=WD_ALIGN_PARAGRAPH.RIGHT
        r=fp.add_run('设计提案  尚未试玩验证    ');setfont(r,8)
        field=OxmlElement('w:fldSimple');field.set(qn('w:instr'),'PAGE');fp._p.append(field)
        self.doc.core_properties.title='背包机甲 游戏设计文档'
        self.doc.core_properties.subject='流程 数值 流派 Boss 美术与开发范围'
        self.doc.core_properties.author='Codex'
        self.doc.core_properties.keywords='游戏设计,Roguelite,背包机甲,设计提案'
    def applybreak(self,p):
        if self.break_pending:p.paragraph_format.page_break_before=True;self.break_pending=False
        return p
    def title(self,t):self.applybreak(self.doc.add_paragraph(t,'Title'))
    def p(self,t):return self.applybreak(self.doc.add_paragraph(t))
    def page(self):self.break_pending=True
    def chapter(self,t):self.page();self.applybreak(self.doc.add_paragraph(t,'Heading 1'))
    def sub(self,t):self.applybreak(self.doc.add_paragraph(t,'Heading 2'))
    def formula(self,t):
        p=self.applybreak(self.doc.add_paragraph())
        math=OxmlElement('m:oMath');r=OxmlElement('m:r');props=OxmlElement('w:rPr')
        fonts=OxmlElement('w:rFonts');fonts.set(qn('w:ascii'),'Arial Unicode MS');fonts.set(qn('w:hAnsi'),'Arial Unicode MS');fonts.set(qn('w:eastAsia'),'Arial Unicode MS');props.append(fonts);r.append(props)
        text=OxmlElement('m:t');text.text=t;r.append(text);math.append(r);p._p.append(math)
    def image(self,name,width,caption):
        p=self.applybreak(self.doc.add_paragraph());p.paragraph_format.keep_with_next=True
        p.paragraph_format.line_spacing=1.0
        p.paragraph_format.line_spacing_rule=WD_LINE_SPACING.SINGLE
        r=p.add_run();shape=r.add_picture(str(ROOT/'assets'/name),width=Inches(width))
        shape._inline.docPr.set('descr',caption)
        self.doc.add_paragraph(caption,'Caption')
    def link(self,t,url):
        p=self.doc.add_paragraph();link=OxmlElement('w:hyperlink');link.set(qn('r:id'),p.part.relate_to(url,RT.HYPERLINK,is_external=True))
        r=OxmlElement('w:r');pr=OxmlElement('w:rPr');col=OxmlElement('w:color');col.set(qn('w:val'),'1C5268');pr.append(col);r.append(pr)
        tx=OxmlElement('w:t');tx.text=t+'  '+url;r.append(tx);link.append(r);p._p.append(link)
    def table(self,headers,rows,widths,small=False):
        t=self.doc.add_table(rows=1,cols=len(headers));t.alignment=WD_TABLE_ALIGNMENT.CENTER;t.autofit=False
        pr=t._tbl.tblPr
        borders=OxmlElement('w:tblBorders')
        for side in ['top','left','bottom','right','insideH','insideV']:
            el=OxmlElement('w:'+side);el.set(qn('w:val'),'single');el.set(qn('w:sz'),'5');el.set(qn('w:color'),'D9D9D9');borders.append(el)
        pr.append(borders)
        margins=OxmlElement('w:tblCellMar')
        for side,val in [('top',75),('bottom',75),('left',85),('right',85)]:
            el=OxmlElement('w:'+side);el.set(qn('w:w'),str(val));el.set(qn('w:type'),'dxa');margins.append(el)
        pr.append(margins)
        for i,w in enumerate(widths):t.columns[i].width=Inches(w)
        for ri,vals in enumerate([headers]+rows):
            row=t.rows[0] if ri==0 else t.add_row()
            rpr=row._tr.get_or_add_trPr();cant=OxmlElement('w:cantSplit');rpr.append(cant)
            if ri==0:
                repeat=OxmlElement('w:tblHeader');rpr.append(repeat)
            for i,v in enumerate(vals):
                cell=row.cells[i];cell.width=Inches(widths[i]);cell.vertical_alignment=WD_CELL_VERTICAL_ALIGNMENT.CENTER
                shade=OxmlElement('w:shd');shade.set(qn('w:fill'),'2E4555' if ri==0 else ('F2F5F6' if ri%2==0 else 'FFFFFF'));cell._tc.get_or_add_tcPr().append(shade)
                p=cell.paragraphs[0];p.paragraph_format.space_after=Pt(0);p.paragraph_format.space_before=Pt(0);p.paragraph_format.line_spacing=Pt(14);p.paragraph_format.line_spacing_rule=WD_LINE_SPACING.EXACTLY
                p.paragraph_format.keep_with_next=False
                if widths[i]<1.05:p.alignment=WD_ALIGN_PARAGRAPH.CENTER
                r=p.add_run(str(v));setfont(r,10 if small else 10.5,ri==0,'FFFFFF' if ri==0 else '000000')
        after=self.doc.add_paragraph();after.paragraph_format.space_after=Pt(3);after.paragraph_format.space_before=Pt(0);after.paragraph_format.line_spacing=.3
        after.add_run().font.size=Pt(2)

make_layout()
d=Writer();compose(d,checks)
target=ROOT/'backpack-mecha-gdd-v0.1.docx'
d.doc.save(target)
print(str(target))
print('paragraphs',len(d.doc.paragraphs),'tables',len(d.doc.tables),'figures',len(d.doc.inline_shapes))
