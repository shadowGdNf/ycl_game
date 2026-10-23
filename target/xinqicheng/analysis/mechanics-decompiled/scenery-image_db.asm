;
; Disassemble of /var/folders/jr/tn4pzbcj2gj37f5cg3w5qbzm0000gn/T/rea-extracted-f265f614-2b91-4e81-a212-02037bc4e4ba/assets/gc32/lib/klove/image_db.lua
;
; Source file: @./lib/klove/image_db.lua
;
; Flags:
;	Stripped: No
;	Endianness: Little
;	FFI: Not present
;

main @./lib/klove/image_db.lua:0-774: 0+ args, 0 upvalues, 9 slots
	;;;; constant tables ;;;;
	ktable#37 = [
		#1: 0,
		#2: 0,
		#3: 0,
		#4: 0,
		]
	
	
	ktable#39 = [
		#1: 255,
		#2: 255,
		#3: 255,
		#4: 255,
		]
	
	
	ktable#41 = [
		]
	
	
	ktable#42 = [
		#1: 0,
		#2: 0,
		#3: 0,
		#4: 255,
		]
	
	
	;;;; upvalue names ;;;;
	;;;; variable info ;;;;
	  7-105:	log
	  9-105:	G
	  11-105:	FS
	  20-105:	km
	  21-105:	image_db
	  64-105:	DEFAULT_ATLAS_1X1_SPRITES
	  65-105:	_MAX_THREADS
	  66-105:	_LOAD_IMAGE_THREAD_CODE
	;;;; instructions ;;;;
	  1	[  6]	GGET 	  0		71	; slot0 = _env["require"]
	  2	[  6]	KSTR 	  1		70	; slot1 = "klua.log"
	  3	[  6]	CALL 	  0	2	2	; slot0 = require(slot1)
	  4	[  6]	MOV  	  1		0	; slot1 = slot0
	  5	[  6]	TGETS	  0	0	69	; slot0 = slot0.new
	  6	[  6]	KSTR 	  2		68	; slot2 = "image_db"
	  7	[  6]	CALL 	  0	2	3	; slot0 = <unknown table>.new(slot1, slot2)
	  8	[  7]	GGET 	  1		67	; slot1 = _env["love"]
	  9	[  7]	TGETS	  1	1	66	; slot1 = love.graphics
	 10	[  8]	GGET 	  2		67	; slot2 = _env["love"]
	 11	[  8]	TGETS	  2	2	65	; slot2 = love.filesystem
	 12	[  9]	GGET 	  3		71	; slot3 = _env["require"]
	 13	[  9]	KSTR 	  4		64	; slot4 = "klua.table"
	 14	[  9]	CALL 	  3	1	2	;  = require(slot4)
	 15	[ 10]	GGET 	  3		71	; slot3 = _env["require"]
	 16	[ 10]	KSTR 	  4		63	; slot4 = "klua.dump"
	 17	[ 10]	CALL 	  3	1	2	;  = require(slot4)
	 18	[ 11]	GGET 	  3		71	; slot3 = _env["require"]
	 19	[ 11]	KSTR 	  4		62	; slot4 = "klua.macros"
	 20	[ 11]	CALL 	  3	2	2	; slot3 = require(slot4)
	 21	[ 29]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
	 22	[ 30]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 23	[ 30]	TSETS	  5	4	61	; image_db.db_images = slot5
	 24	[ 31]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 25	[ 31]	TSETS	  5	4	60	; image_db.db_atlas = slot5
	 26	[ 32]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 27	[ 32]	TSETS	  5	4	59	; image_db.atlas_uses = slot5
	 28	[ 33]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 29	[ 33]	TSETS	  5	4	58	; image_db.load_queue = slot5
	 30	[ 34]	KPRI 	  5		0	; slot5 = nil
	 31	[ 34]	TSETS	  5	4	57	; image_db.load_queue_current = slot5
	 32	[ 35]	KSHORT	  5		0	; slot5 = 0
	 33	[ 35]	TSETS	  5	4	56	; image_db.progress = slot5
	 34	[ 36]	KSHORT	  5		0	; slot5 = 0
	 35	[ 36]	TSETS	  5	4	55	; image_db.groups_total = slot5
	 36	[ 37]	KSHORT	  5		0	; slot5 = 0
	 37	[ 37]	TSETS	  5	4	54	; image_db.groups_done = slot5
	 38	[ 38]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 39	[ 38]	TSETS	  5	4	53	; image_db.missing_images = slot5
	 40	[ 39]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 41	[ 39]	TSETS	  5	4	52	; image_db.missing_sprites = slot5
	 42	[ 40]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 43	[ 40]	TSETS	  5	4	51	; image_db.threads = slot5
	 44	[ 41]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 45	[ 41]	TSETS	  5	4	50	; image_db.image_name_queue = slot5
	 46	[ 42]	KSHORT	  5		0	; slot5 = 0
	 47	[ 42]	TSETS	  5	4	49	; image_db.queue_load_total_images = slot5
	 48	[ 43]	KSHORT	  5		0	; slot5 = 0
	 49	[ 43]	TSETS	  5	4	48	; image_db.queue_load_done_images = slot5
	 50	[ 44]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 51	[ 44]	TSETS	  5	4	47	; image_db.last_preloaded_group_names = slot5
	 52	[ 45]	KPRI 	  5		2	; slot5 = true
	 53	[ 45]	TSETS	  5	4	46	; image_db.use_canvas = slot5
	 54	[ 46]	KPRI 	  5		1	; slot5 = false
	 55	[ 46]	TSETS	  5	4	45	; image_db.release_compressed_data = slot5
	 56	[ 48]	KSTR 	  5		44	; slot5 = "image_db_default"
	 57	[ 48]	GSET 	  5		43	; _env["IMAGE_DB_DEFAULT_ATLAS_GROUP"] = slot5
	 58	[ 49]	TDUP 	  5		41	; slot5 = copy table#k41
	 59	[ 50]	TDUP 	  6		42	; slot6 = copy table#k42
	 60	[ 50]	TSETS	  6	5	40	; slot5._1x1_black = slot6
	 61	[ 51]	TDUP 	  6		39	; slot6 = copy table#k39
	 62	[ 51]	TSETS	  6	5	38	; slot5._1x1_white = slot6
	 63	[ 52]	TDUP 	  6		37	; slot6 = copy table#k37
	 64	[ 52]	TSETS	  6	5	36	; slot5._1x1_transparent = slot6
	 65	[ 57]	KSHORT	  6		8	; slot6 = 8
	 66	[102]	KSTR 	  7		35	; slot7 = "local cin,cout,th_i = ...
	require 'love.filesystem'
	require 'love.image'
	require 'love.timer'
	local file_count = 0
	while true do
	    -- get params
	    local fn = cin:demand()
	    if fn == 'QUIT' then goto quit end
	    local path = cin:demand()
	    local f = path .. '/' .. fn
	
	    --print('TH  ' ..th_i.. ' ARGS ' .. fn .. ' ' .. path .. '\n')
	    
	    if not love.filesystem.isFile(f) then
	        cout:push({'ERROR','Not a file',f})
	    else
	        local data
	        if string.match(fn, '.pkm.lz4$') or string.match(fn, '.ktx.lz4$') or string.match(fn, '.ktx$') or string.match(fn, '.pkm$') or string.match(fn, '.astc$') or string.match(fn, '.dds$') then
	            data = love.image.newCompressedData(f)
	        else
	            data = love.image.newImageData(f)
	        end
	        --print('TH  ' ..th_i.. ' newXData time: ' .. (love.timer.getTime()-t_start) .. '\n')
	        if not data then
	            cout:push({'ERROR','Image could not be loaded',f})
	        else
	            file_count = file_count + 1
	            local w,h = data:getDimensions()
	            local key = string.gsub(fn, '.png$', '')
	            key = string.gsub(key, '.lz4$', '')
	            key = string.gsub(key, '.jpg$', '')
	            key = string.gsub(key, '.pkm$', '')
	            key = string.gsub(key, '.ktx$', '')
	            key = string.gsub(key, '.astc$', '')
	            key = string.gsub(key, '.dds$', '')
	            cout:push({'OK',key,data,w,h})
	        end
	    end
	end
	::quit::
	cout:supply({'DONE'})
	--print('TH  ' ..th_i.. ' QUIT - FILES LOADED ' .. file_count .. '\n')
	"
	 67	[127]	FNEW 	  8		33	; @./lib/klove/image_db.lua:105-127: 1 args, 0 upvalues, 12 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-56:	self
		  1-56:	count_frames
		  2-56:	o
		  3-56:	list
		  9-13:	<generator>
		  9-13:	<state>
		  9-13:	<control>
		  10-11:	k
		  10-11:	v
		  23-35:	<generator>
		  23-35:	<state>
		  23-35:	<control>
		  24-33:	k
		  24-33:	v
		;;;; instructions ;;;;
		  1	[106]	KSHORT	  1		0	; slot1 = 0
		  2	[107]	KSTR 	  2		16	; slot2 = ""
		  3	[108]	TNEW 	  3		0	; slot3 = new table( array: 0, dict: 1)
		  4	[109]	MOV  	  4		2	; slot4 = o
		  5	[109]	KSTR 	  5		15	; slot5 = "Atlas frames count: "
		  6	[109]	CAT  	  2	4	5	; slot2 = o .. slot5
		  7	[110]	GGET 	  4		14	; slot4 = _env["pairs"]
		  8	[110]	TGETS	  5	0	13	; slot5 = self.db_atlas
		  9	[110]	CALL 	  4	4	2	; slot4, slot5, slot6 = pairs(self.db_atlas)
		 10	[110]	ISNEXT	  7		1	; Verify ITERN at 12; goto 12
		 11	[111]	ADDVN	  1	1	0	; slot1 = count_frames + 1
		 12	[110]	ITERN	  7	3	3	; slot7, slot8, slot9 = slot4<generator>, slot5<state>, slot6<control>; slot7, slot8 = slot4<generator>(slot5<state>, slot6<control>)
		 13	[110]	ITERL	  7		-3	; slot6<control> = slot7; if slot7 != nil goto 11
		 14	[113]	MOV  	  4		2	; slot4 = o
		 15	[113]	MOV  	  5		1	; slot5 = count_frames
		 16	[113]	KSTR 	  6		12	; slot6 = "
		"
		 17	[113]	CAT  	  2	4	6	; slot2 = o .. count_frames .. slot6
		 18	[114]	MOV  	  4		2	; slot4 = o
		 19	[114]	KSTR 	  5		11	; slot5 = "Loaded images: "
		 20	[114]	CAT  	  2	4	5	; slot2 = o .. slot5
		 21	[115]	GGET 	  4		14	; slot4 = _env["pairs"]
		 22	[115]	TGETS	  5	0	10	; slot5 = self.db_images
		 23	[115]	CALL 	  4	4	2	; slot4, slot5, slot6 = pairs(self.db_images)
		 24	[115]	ISNEXT	  7		9	; Verify ITERN at 34; goto 34
		 25	[116]	TGETB	  9	8	1	; slot9 = v[1]
		 26	[116]	ISF  	   		9	; if not slot9
		 27	[116]	JMP  	 10		6	; 	goto 34
		 28	[117]	GGET 	  9		9	; slot9 = _env["table"]
		 29	[117]	TGETS	  9	9	8	; slot9 = table.insert
		 30	[117]	MOV  	 10		3	; slot10 = list
		 31	[117]	MOV  	 11		7	; slot11 = k
		 32	[117]	CALL 	  9	1	3	;  = table.insert(list, k)
		 33	[117]	JMP  	  9		0	; 	goto 34
		 34	[115]	ITERN	  7	3	3	; slot7, slot8, slot9 = slot4<generator>, slot5<state>, slot6<control>; slot7, slot8 = slot4<generator>(slot5<state>, slot6<control>)
		 35	[115]	ITERL	  7		-11	; slot6<control> = slot7; if slot7 != nil goto 25
		 36	[122]	GGET 	  4		9	; slot4 = _env["table"]
		 37	[122]	TGETS	  4	4	7	; slot4 = table.sort
		 38	[122]	MOV  	  5		3	; slot5 = list
		 39	[122]	CALL 	  4	1	2	;  = table.sort(list)
		 40	[123]	MOV  	  4		2	; slot4 = o
		 41	[123]	GGET 	  5		9	; slot5 = _env["table"]
		 42	[123]	TGETS	  5	5	6	; slot5 = table.concat
		 43	[123]	MOV  	  6		3	; slot6 = list
		 44	[123]	KSTR 	  7		5	; slot7 = ", "
		 45	[123]	CALL 	  5	2	3	; slot5 = table.concat(list, slot7)
		 46	[123]	CAT  	  2	4	5	; slot2 = o .. table.concat
		 47	[124]	MOV  	  4		2	; slot4 = o
		 48	[124]	KSTR 	  5		4	; slot5 = "
		Texture memory (MB): "
		 49	[124]	GGET 	  6		3	; slot6 = _env["love"]
		 50	[124]	TGETS	  6	6	2	; slot6 = love.graphics
		 51	[124]	TGETS	  6	6	1	; slot6 = love.graphics.getStats
		 52	[124]	CALL 	  6	2	1	; slot6 = love.graphics.getStats()
		 53	[124]	TGETS	  6	6	0	; slot6 = love.graphics.getStats.texturememory
		 54	[124]	DIVVN	  6	6	1	; slot6 = love.graphics.getStats.texturememory / 1048576
		 55	[124]	CAT  	  2	4	6	; slot2 = o .. slot5 .. slot6
		 56	[126]	RET1 	  2		2	; return o
	 68	[105]	TSETS	  8	4	34	; image_db.get_short_stats = slot8
	 69	[172]	FNEW 	  8		31	; @./lib/klove/image_db.lua:129-172: 2 args, 0 upvalues, 21 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-124:	self
		  0-124:	detailed
		  1-124:	count_images
		  2-124:	count_images_MB
		  3-124:	count_frames
		  4-124:	count_images_deferred
		  5-124:	o
		  9-124:	list
		  12-48:	<generator>
		  12-48:	<state>
		  12-48:	<control>
		  13-46:	k
		  13-46:	v
		  22-44:	mb
		  27-44:	line
		  55-61:	<generator>
		  55-61:	<state>
		  55-61:	<control>
		  56-59:	_
		  56-59:	row
		  70-79:	<generator>
		  70-79:	<state>
		  70-79:	<control>
		  71-77:	k
		  71-77:	v
		  82-86:	<generator>
		  82-86:	<state>
		  82-86:	<control>
		  83-84:	k
		  83-84:	v
		;;;; instructions ;;;;
		  1	[130]	KSHORT	  2		0	; slot2 = 0
		  2	[131]	KSHORT	  3		0	; slot3 = 0
		  3	[132]	KSHORT	  4		0	; slot4 = 0
		  4	[133]	KSHORT	  5		0	; slot5 = 0
		  5	[134]	KSTR 	  6		25	; slot6 = ""
		  6	[135]	MOV  	  7		6	; slot7 = o
		  7	[135]	KSTR 	  8		24	; slot8 = "Loaded images ------------------
		"
		  8	[135]	CAT  	  6	7	8	; slot6 = o .. slot8
		  9	[136]	TNEW 	  7		0	; slot7 = new table( array: 0, dict: 1)
		 10	[137]	GGET 	  8		23	; slot8 = _env["pairs"]
		 11	[137]	TGETS	  9	0	22	; slot9 = self.db_images
		 12	[137]	CALL 	  8	4	2	; slot8, slot9, slot10 = pairs(self.db_images)
		 13	[137]	ISNEXT	 11		33	; Verify ITERN at 47; goto 47
		 14	[138]	TGETB	 13	12	1	; slot13 = v[1]
		 15	[138]	ISF  	   		13	; if not slot13
		 16	[138]	JMP  	 14		29	; 	goto 46
		 17	[139]	ADDVN	  2	2	0	; slot2 = count_images + 1
		 18	[140]	TGETB	 13	12	2	; slot13 = v[2]
		 19	[140]	TGETB	 14	12	3	; slot14 = v[3]
		 20	[140]	MULVV	 13	13	14	; slot13 = slot13 * slot14
		 21	[140]	MULVN	 13	13	1	; slot13 = slot13 * 4
		 22	[140]	DIVVN	 13	13	2	; slot13 = slot13 / 1048576
		 23	[141]	ADDVV	  3	3	13	; slot3 = count_images_MB + mb
		 24	[142]	MOV  	 14		11	; slot14 = k
		 25	[142]	KSTR 	 15		21	; slot15 = "    "
		 26	[142]	TGETB	 16	12	2	; slot16 = v[2]
		 27	[142]	CAT  	 14	14	16	; slot14 = k .. slot15 .. slot16
		 28	[143]	ISF  	   		1	; if not detailed
		 29	[143]	JMP  	 15		7	; 	goto 37
		 30	[144]	MOV  	 15		14	; slot15 = line
		 31	[144]	KSTR 	 16		20	; slot16 = "x"
		 32	[144]	TGETB	 17	12	3	; slot17 = v[3]
		 33	[144]	KSTR 	 18		19	; slot18 = " ("
		 34	[144]	MOV  	 19		13	; slot19 = mb
		 35	[144]	KSTR 	 20		18	; slot20 = ")"
		 36	[144]	CAT  	 14	15	20	; slot14 = line .. slot16 .. slot17 .. slot18 .. mb .. slot20
		 37	[146]	MOV  	 15		14	; slot15 = line
		 38	[146]	KSTR 	 16		17	; slot16 = "
		"
		 39	[146]	CAT  	 14	15	16	; slot14 = line .. slot16
		 40	[147]	GGET 	 15		16	; slot15 = _env["table"]
		 41	[147]	TGETS	 15	15	15	; slot15 = table.insert
		 42	[147]	MOV  	 16		7	; slot16 = list
		 43	[147]	MOV  	 17		14	; slot17 = line
		 44	[147]	CALL 	 15	1	3	;  = table.insert(list, line)
		 45	[147]	JMP  	 13		1	; 	goto 47
		 46	[149]	ADDVN	  5	5	0	; slot5 = count_images_deferred + 1
		 47	[137]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		 48	[137]	ITERL	 11		-35	; slot10<control> = slot11; if slot11 != nil goto 14
		 49	[152]	GGET 	  8		16	; slot8 = _env["table"]
		 50	[152]	TGETS	  8	8	14	; slot8 = table.sort
		 51	[152]	MOV  	  9		7	; slot9 = list
		 52	[152]	CALL 	  8	1	2	;  = table.sort(list)
		 53	[153]	GGET 	  8		23	; slot8 = _env["pairs"]
		 54	[153]	MOV  	  9		7	; slot9 = list
		 55	[153]	CALL 	  8	4	2	; slot8, slot9, slot10 = pairs(list)
		 56	[153]	ISNEXT	 11		3	; Verify ITERN at 60; goto 60
		 57	[153]	MOV  	 13		6	; slot13 = o
		 58	[153]	MOV  	 14		12	; slot14 = row
		 59	[153]	CAT  	  6	13	14	; slot6 = o .. row
		 60	[153]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		 61	[153]	ITERL	 11		-5	; slot10<control> = slot11; if slot11 != nil goto 57
		 62	[154]	MOV  	  8		6	; slot8 = o
		 63	[154]	KSTR 	  9		17	; slot9 = "
		"
		 64	[154]	CAT  	  6	8	9	; slot6 = o .. slot9
		 65	[155]	MOV  	  8		6	; slot8 = o
		 66	[155]	KSTR 	  9		13	; slot9 = "Atlas usage---------------------
		"
		 67	[155]	CAT  	  6	8	9	; slot6 = o .. slot9
		 68	[156]	GGET 	  8		23	; slot8 = _env["pairs"]
		 69	[156]	TGETS	  9	0	12	; slot9 = self.atlas_uses
		 70	[156]	CALL 	  8	4	2	; slot8, slot9, slot10 = pairs(self.atlas_uses)
		 71	[156]	ISNEXT	 11		6	; Verify ITERN at 78; goto 78
		 72	[157]	MOV  	 13		6	; slot13 = o
		 73	[157]	MOV  	 14		11	; slot14 = k
		 74	[157]	KSTR 	 15		11	; slot15 = ":"
		 75	[157]	MOV  	 16		12	; slot16 = v
		 76	[157]	KSTR 	 17		17	; slot17 = "
		"
		 77	[157]	CAT  	  6	13	17	; slot6 = o .. k .. slot15 .. v .. slot17
		 78	[156]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		 79	[156]	ITERL	 11		-8	; slot10<control> = slot11; if slot11 != nil goto 72
		 80	[159]	GGET 	  8		23	; slot8 = _env["pairs"]
		 81	[159]	TGETS	  9	0	10	; slot9 = self.db_atlas
		 82	[159]	CALL 	  8	4	2	; slot8, slot9, slot10 = pairs(self.db_atlas)
		 83	[159]	ISNEXT	 11		1	; Verify ITERN at 85; goto 85
		 84	[160]	ADDVN	  4	4	0	; slot4 = count_frames + 1
		 85	[159]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		 86	[159]	ITERL	 11		-3	; slot10<control> = slot11; if slot11 != nil goto 84
		 87	[162]	MOV  	  8		6	; slot8 = o
		 88	[162]	KSTR 	  9		17	; slot9 = "
		"
		 89	[162]	CAT  	  6	8	9	; slot6 = o .. slot9
		 90	[163]	MOV  	  8		6	; slot8 = o
		 91	[163]	KSTR 	  9		9	; slot9 = "Counts---------------------
		"
		 92	[163]	CAT  	  6	8	9	; slot6 = o .. slot9
		 93	[164]	MOV  	  8		6	; slot8 = o
		 94	[164]	KSTR 	  9		8	; slot9 = "Total images: "
		 95	[164]	MOV  	 10		2	; slot10 = count_images
		 96	[164]	KSTR 	 11		19	; slot11 = " ("
		 97	[164]	MOV  	 12		3	; slot12 = count_images_MB
		 98	[164]	KSTR 	 13		7	; slot13 = " MB)
		"
		 99	[164]	CAT  	  6	8	13	; slot6 = o .. slot9 .. count_images .. slot11 .. count_images_MB .. slot13
		100	[165]	MOV  	  8		6	; slot8 = o
		101	[165]	KSTR 	  9		6	; slot9 = "Total deferred images: "
		102	[165]	MOV  	 10		5	; slot10 = count_images_deferred
		103	[165]	KSTR 	 11		17	; slot11 = "
		"
		104	[165]	CAT  	  6	8	11	; slot6 = o .. slot9 .. count_images_deferred .. slot11
		105	[166]	MOV  	  8		6	; slot8 = o
		106	[166]	KSTR 	  9		5	; slot9 = "Total frames: "
		107	[166]	MOV  	 10		4	; slot10 = count_frames
		108	[166]	KSTR 	 11		17	; slot11 = "
		"
		109	[166]	CAT  	  6	8	11	; slot6 = o .. slot9 .. count_frames .. slot11
		110	[167]	MOV  	  8		6	; slot8 = o
		111	[167]	KSTR 	  9		17	; slot9 = "
		"
		112	[167]	CAT  	  6	8	9	; slot6 = o .. slot9
		113	[168]	MOV  	  8		6	; slot8 = o
		114	[168]	KSTR 	  9		4	; slot9 = "love.graphics.getStats()---
		"
		115	[168]	CAT  	  6	8	9	; slot6 = o .. slot9
		116	[169]	MOV  	  8		6	; slot8 = o
		117	[169]	GGET 	  9		3	; slot9 = _env["getdump"]
		118	[169]	GGET 	 10		2	; slot10 = _env["love"]
		119	[169]	TGETS	 10	10	1	; slot10 = love.graphics
		120	[169]	TGETS	 10	10	0	; slot10 = love.graphics.getStats
		121	[169]	CALL 	 10	0	1	; MULTRES = love.graphics.getStats()
		122	[169]	CALLM	  9	2	0	; slot9 = getdump(, ...MULTRES)
		123	[169]	CAT  	  6	8	9	; slot6 = o .. getdump
		124	[171]	RET1 	  6		2	; return o
	 70	[129]	TSETS	  8	4	32	; image_db.get_stats = slot8
	 71	[317]	FNEW 	  8		29	; @./lib/klove/image_db.lua:175-317: 1 args, 5 upvalues, 23 slots
		
		;;;; constant tables ;;;;
		ktable#39 = [
			#1: false,
			#2: true,
			#3: true,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	log
		  1:	_MAX_THREADS
		  2:	_LOAD_IMAGE_THREAD_CODE
		  3:	km
		  4:	G
		;;;; variable info ;;;;
		  0-362:	self
		  27-61:	<index>
		  27-61:	<limit>
		  27-61:	<step>
		  28-60:	i
		  33-60:	item
		  36-60:	ref_scale
		  36-60:	path
		  36-60:	name
		  42-60:	image_names
		  47-60:	<generator>
		  47-60:	<state>
		  47-60:	<control>
		  48-58:	n
		  73-120:	<index>
		  73-120:	<limit>
		  73-120:	<step>
		  74-119:	i
		  79-119:	th
		  83-119:	cin
		  87-119:	cout
		  131-160:	<index>
		  131-160:	<limit>
		  131-160:	<step>
		  132-159:	j
		  139-159:	image_name
		  139-159:	path
		  143-159:	cin
		  164-173:	<index>
		  164-173:	<limit>
		  164-173:	<step>
		  165-172:	i
		  185-327:	<index>
		  185-327:	<limit>
		  185-327:	<step>
		  186-326:	i
		  190-326:	th
		  190-326:	cin
		  190-326:	cout
		  198-312:	result
		  203-312:	r1
		  203-312:	r2
		  203-312:	r3
		  203-312:	r4
		  203-312:	r5
		  226-312:	key
		  226-312:	data
		  226-312:	w
		  226-312:	h
		  230-312:	im
		  256-286:	c
		;;;; instructions ;;;;
		  1	[178]	TGETS	  1	0	63	; slot1 = self.load_queue
		  2	[178]	LEN  	  1		1	; slot1 = #self.load_queue
		  3	[178]	ISNEN	  1		0	; if slot1 ~= 0
		  4	[178]	JMP  	  1		10	; 	goto 15
		  5	[178]	TGETS	  1	0	62	; slot1 = self.threads
		  6	[178]	LEN  	  1		1	; slot1 = #self.threads
		  7	[178]	ISNEN	  1		0	; if slot1 ~= 0
		  8	[178]	JMP  	  1		6	; 	goto 15
		  9	[179]	KSHORT	  1		1	; slot1 = 1
		 10	[179]	TSETS	  1	0	61	; self.progress = slot1
		 11	[180]	KSHORT	  1		0	; slot1 = 0
		 12	[180]	TSETS	  1	0	60	; self.groups_total = slot1
		 13	[181]	KPRI 	  1		2	; slot1 = true
		 14	[181]	RET1 	  1		2	; return slot1
		 15	[183]	TGETS	  1	0	59	; slot1 = self.queue_load_start_time
		 16	[183]	IST  	   		1	; if self.queue_load_start_time
		 17	[183]	JMP  	  1		6	; 	goto 24
		 18	[184]	UGET 	  1		0	; slot1 = uv0"log"
		 19	[184]	TGETS	  1	1	58	; slot1 = uv0"log".start_time
		 20	[184]	KSTR 	  2		57	; slot2 = "textures"
		 21	[184]	CALL 	  1	1	2	;  = uv0"log".start_time(slot2)
		 22	[185]	KPRI 	  1		2	; slot1 = true
		 23	[185]	TSETS	  1	0	59	; self.queue_load_start_time = slot1
		 24	[191]	KSHORT	  1		1	; slot1 = 1
		 25	[191]	TGETS	  2	0	63	; slot2 = self.load_queue
		 26	[191]	LEN  	  2		2	; slot2 = #self.load_queue
		 27	[191]	KSHORT	  3		1	; slot3 = 1
		 28	[191]	FORI 	  1		33	; for slot4 = slot1,slot2,slot3 else goto 62
		 29	[192]	GGET 	  5		56	; slot5 = _env["table"]
		 30	[192]	TGETS	  5	5	55	; slot5 = table.remove
		 31	[192]	TGETS	  6	0	63	; slot6 = self.load_queue
		 32	[192]	KSHORT	  7		1	; slot7 = 1
		 33	[192]	CALL 	  5	2	3	; slot5 = table.remove(self.load_queue, slot7)
		 34	[193]	GGET 	  6		54	; slot6 = _env["unpack"]
		 35	[193]	MOV  	  7		5	; slot7 = item
		 36	[193]	CALL 	  6	4	2	; slot6, slot7, slot8 = unpack(item)
		 37	[194]	MOV  	 10		0	; slot10 = self
		 38	[194]	TGETS	  9	0	53	; slot9 = self.preload_atlas
		 39	[194]	MOV  	 11		6	; slot11 = ref_scale
		 40	[194]	MOV  	 12		7	; slot12 = path
		 41	[194]	MOV  	 13		8	; slot13 = name
		 42	[194]	CALL 	  9	2	5	; slot9 = self.preload_atlas(self, ref_scale, path, name)
		 43	[195]	ISF  	   		9	; if not image_names
		 44	[195]	JMP  	 10		16	; 	goto 61
		 45	[196]	GGET 	 10		52	; slot10 = _env["pairs"]
		 46	[196]	MOV  	 11		9	; slot11 = image_names
		 47	[196]	CALL 	 10	4	2	; slot10, slot11, slot12 = pairs(image_names)
		 48	[196]	ISNEXT	 13		10	; Verify ITERN at 59; goto 59
		 49	[197]	GGET 	 14		56	; slot14 = _env["table"]
		 50	[197]	TGETS	 14	14	51	; slot14 = table.insert
		 51	[197]	TGETS	 15	0	50	; slot15 = self.image_name_queue
		 52	[197]	TNEW 	 16		3	; slot16 = new table( array: 3, dict: 1)
		 53	[197]	TSETB	 13	16	1	; slot16[1] = n
		 54	[197]	TSETB	  7	16	2	; slot16[2] = path
		 55	[197]	CALL 	 14	1	3	;  = table.insert(self.image_name_queue, slot16)
		 56	[198]	TGETS	 14	0	49	; slot14 = self.queue_load_total_images
		 57	[198]	ADDVN	 14	14	1	; slot14 = self.queue_load_total_images + 1
		 58	[198]	TSETS	 14	0	49	; self.queue_load_total_images = slot14
		 59	[196]	ITERN	 13	2	3	; slot13, slot14, slot15 = slot10<generator>, slot11<state>, slot12<control>; slot13 = slot10<generator>(slot11<state>, slot12<control>)
		 60	[196]	ITERL	 13		-12	; slot12<control> = name; if name != nil goto 49
		 61	[191]	FORL 	  1		-33	; slot4 = slot4 + slot3<step>; if cmp(slot4, sign slot3<step>,  slot2<limit>) goto 29
		 62	[204]	TGETS	  1	0	62	; slot1 = self.threads
		 63	[204]	LEN  	  1		1	; slot1 = #self.threads
		 64	[204]	ISNEN	  1		0	; if slot1 ~= 0
		 65	[204]	JMP  	  1		57	; 	goto 123
		 66	[205]	KSHORT	  1		1	; slot1 = 1
		 67	[205]	GGET 	  2		48	; slot2 = _env["math"]
		 68	[205]	TGETS	  2	2	47	; slot2 = math.min
		 69	[205]	TGETS	  3	0	50	; slot3 = self.image_name_queue
		 70	[205]	LEN  	  3		3	; slot3 = #self.image_name_queue
		 71	[205]	UGET 	  4		1	; slot4 = uv1"_MAX_THREADS"
		 72	[205]	CALL 	  2	2	3	; slot2 = math.min(slot3, uv1"_MAX_THREADS")
		 73	[205]	KSHORT	  3		1	; slot3 = 1
		 74	[205]	FORI 	  1		46	; for uv1"_MAX_THREADS" = slot1,slot2,slot3 else goto 121
		 75	[206]	GGET 	  5		46	; slot5 = _env["love"]
		 76	[206]	TGETS	  5	5	45	; slot5 = love.thread
		 77	[206]	TGETS	  5	5	44	; slot5 = love.thread.newThread
		 78	[206]	UGET 	  6		2	; slot6 = uv2"_LOAD_IMAGE_THREAD_CODE"
		 79	[206]	CALL 	  5	2	2	; slot5 = love.thread.newThread(uv2"_LOAD_IMAGE_THREAD_CODE")
		 80	[207]	GGET 	  6		46	; slot6 = _env["love"]
		 81	[207]	TGETS	  6	6	45	; slot6 = love.thread
		 82	[207]	TGETS	  6	6	43	; slot6 = love.thread.newChannel
		 83	[207]	CALL 	  6	2	1	; slot6 = love.thread.newChannel()
		 84	[208]	GGET 	  7		46	; slot7 = _env["love"]
		 85	[208]	TGETS	  7	7	45	; slot7 = love.thread
		 86	[208]	TGETS	  7	7	43	; slot7 = love.thread.newChannel
		 87	[208]	CALL 	  7	2	1	; slot7 = love.thread.newChannel()
		 88	[209]	MOV  	  9		5	; slot9 = th
		 89	[209]	TGETS	  8	5	42	; slot8 = th.start
		 90	[209]	MOV  	 10		6	; slot10 = cin
		 91	[209]	MOV  	 11		7	; slot11 = cout
		 92	[209]	MOV  	 12		4	; slot12 = i
		 93	[209]	CALL 	  8	1	5	;  = th.start(th, cin, cout, i)
		 94	[210]	GGET 	  8		46	; slot8 = _env["love"]
		 95	[210]	TGETS	  8	8	41	; slot8 = love.nx
		 96	[210]	ISF  	   		8	; if not love.nx
		 97	[210]	JMP  	  9		14	; 	goto 112
		 98	[211]	MOV  	  9		5	; slot9 = th
		 99	[211]	TGETS	  8	5	40	; slot8 = th.setAffinity
		100	[211]	TDUP 	 10		39	; slot10 = copy table#k39
		101	[211]	CALL 	  8	1	3	;  = th.setAffinity(th, slot10)
		102	[212]	UGET 	  8		0	; slot8 = uv0"log"
		103	[212]	TGETS	  8	8	38	; slot8 = uv0"log".paranoid
		104	[212]	KSTR 	  9		37	; slot9 = " ++++ IMAGE_DB THREAD %s AFFINITY %s"
		105	[212]	MOV  	 10		5	; slot10 = th
		106	[212]	GGET 	 11		36	; slot11 = _env["getdump"]
		107	[212]	MOV  	 13		5	; slot13 = th
		108	[212]	TGETS	 12	5	35	; slot12 = th.getAffinity
		109	[212]	CALL 	 12	0	2	; MULTRES = th.getAffinity(th)
		110	[212]	CALLM	 11	0	0	; MULTRES = getdump(, ...MULTRES)
		111	[212]	CALLM	  8	1	2	;  = uv0"log".paranoid(slot9, th, ...MULTRES)
		112	[214]	GGET 	  8		56	; slot8 = _env["table"]
		113	[214]	TGETS	  8	8	51	; slot8 = table.insert
		114	[214]	TGETS	  9	0	62	; slot9 = self.threads
		115	[214]	TNEW 	 10		4	; slot10 = new table( array: 4, dict: 1)
		116	[214]	TSETB	  5	10	1	; slot10[1] = th
		117	[214]	TSETB	  6	10	2	; slot10[2] = cin
		118	[214]	TSETB	  7	10	3	; slot10[3] = cout
		119	[214]	CALL 	  8	1	3	;  = table.insert(self.threads, slot10)
		120	[205]	FORL 	  1		-46	; slot4 = slot4 + slot3<step>; if cmp(slot4, sign slot3<step>,  slot2<limit>) goto 75
		121	[216]	KSHORT	  1		1	; slot1 = 1
		122	[216]	TSETS	  1	0	34	; self.last_thread_used = slot1
		123	[220]	TGETS	  1	0	50	; slot1 = self.image_name_queue
		124	[220]	LEN  	  1		1	; slot1 = #self.image_name_queue
		125	[220]	KSHORT	  2		0	; slot2 = 0
		126	[220]	ISGE 	  2		1	; if slot2 >= slot1
		127	[220]	JMP  	  1		33	; 	goto 161
		128	[222]	KSHORT	  1		1	; slot1 = 1
		129	[222]	TGETS	  2	0	50	; slot2 = self.image_name_queue
		130	[222]	LEN  	  2		2	; slot2 = #self.image_name_queue
		131	[222]	KSHORT	  3		1	; slot3 = 1
		132	[222]	FORI 	  1		28	; for slot4 = slot1,slot2,slot3 else goto 161
		133	[223]	GGET 	  5		54	; slot5 = _env["unpack"]
		134	[223]	GGET 	  6		56	; slot6 = _env["table"]
		135	[223]	TGETS	  6	6	55	; slot6 = table.remove
		136	[223]	TGETS	  7	0	50	; slot7 = self.image_name_queue
		137	[223]	KSHORT	  8		1	; slot8 = 1
		138	[223]	CALL 	  6	0	3	; MULTRES = table.remove(self.image_name_queue, slot8)
		139	[223]	CALLM	  5	3	0	; slot5, slot6 = unpack(, ...MULTRES)
		140	[224]	TGETS	  7	0	62	; slot7 = self.threads
		141	[224]	TGETS	  8	0	34	; slot8 = self.last_thread_used
		142	[224]	TGETV	  7	7	8	; slot7 = self.threads[self.last_thread_used]
		143	[224]	TGETB	  7	7	2	; slot7 = slot7[2]
		144	[225]	MOV  	  9		7	; slot9 = cin
		145	[225]	TGETS	  8	7	33	; slot8 = cin.push
		146	[225]	MOV  	 10		5	; slot10 = image_name
		147	[225]	CALL 	  8	1	3	;  = cin.push(cin, image_name)
		148	[226]	MOV  	  9		7	; slot9 = cin
		149	[226]	TGETS	  8	7	33	; slot8 = cin.push
		150	[226]	MOV  	 10		6	; slot10 = path
		151	[226]	CALL 	  8	1	3	;  = cin.push(cin, path)
		152	[227]	UGET 	  8		3	; slot8 = uv3"km"
		153	[227]	TGETS	  8	8	32	; slot8 = uv3"km".zmod
		154	[227]	TGETS	  9	0	34	; slot9 = self.last_thread_used
		155	[227]	ADDVN	  9	9	1	; slot9 = self.last_thread_used + 1
		156	[227]	TGETS	 10	0	62	; slot10 = self.threads
		157	[227]	LEN  	 10		10	; slot10 = #self.threads
		158	[227]	CALL 	  8	2	3	; slot8 = uv3"km".zmod(slot9, slot10)
		159	[227]	TSETS	  8	0	34	; self.last_thread_used = uv3"km".zmod
		160	[222]	FORL 	  1		-28	; slot4 = slot4 + slot3<step>; if cmp(slot4, sign slot3<step>,  slot2<limit>) goto 133
		161	[232]	KSHORT	  1		1	; slot1 = 1
		162	[232]	TGETS	  2	0	62	; slot2 = self.threads
		163	[232]	LEN  	  2		2	; slot2 = #self.threads
		164	[232]	KSHORT	  3		1	; slot3 = 1
		165	[232]	FORI 	  1		8	; for slot4 = slot1,slot2,slot3 else goto 174
		166	[233]	TGETS	  5	0	62	; slot5 = self.threads
		167	[233]	TGETV	  5	5	4	; slot5 = self.threads[i]
		168	[233]	TGETB	  5	5	2	; slot5 = slot5[2]
		169	[233]	MOV  	  6		5	; slot6 = slot5
		170	[233]	TGETS	  5	5	33	; slot5 = slot5.push
		171	[233]	KSTR 	  7		31	; slot7 = "QUIT"
		172	[233]	CALL 	  5	1	3	;  = <unknown table>.push(slot6, slot7)
		173	[232]	FORL 	  1		-8	; slot4 = slot4 + slot3<step>; if cmp(slot4, sign slot3<step>,  slot2<limit>) goto 166
		174	[237]	GGET 	  1		46	; slot1 = _env["love"]
		175	[237]	TGETS	  1	1	30	; slot1 = love.graphics
		176	[237]	TGETS	  1	1	29	; slot1 = love.graphics.isActive
		177	[237]	CALL 	  1	2	1	; slot1 = love.graphics.isActive()
		178	[237]	IST  	   		1	; if slot1
		179	[237]	JMP  	  1		2	; 	goto 182
		180	[244]	KPRI 	  1		1	; slot1 = false
		181	[244]	RET1 	  1		2	; return slot1
		182	[248]	TGETS	  1	0	62	; slot1 = self.threads
		183	[248]	LEN  	  1		1	; slot1 = #self.threads
		184	[248]	KSHORT	  2		1	; slot2 = 1
		185	[248]	KSHORT	  3		65535	; slot3 = 65535
		186	[248]	FORI 	  1		141	; for slot4 = slot1,slot2,slot3 else goto 328
		187	[249]	GGET 	  5		54	; slot5 = _env["unpack"]
		188	[249]	TGETS	  6	0	62	; slot6 = self.threads
		189	[249]	TGETV	  6	6	4	; slot6 = self.threads[i]
		190	[249]	CALL 	  5	4	2	; slot5, slot6, slot7 = unpack(slot6)
		191	[250]	MOV  	  9		5	; slot9 = th
		192	[250]	TGETS	  8	5	28	; slot8 = th.isRunning
		193	[250]	CALL 	  8	2	2	; slot8 = th.isRunning(th)
		194	[250]	ISF  	   		8	; if not th.isRunning
		195	[250]	JMP  	  9		118	; 	goto 314
		196	[251]	MOV  	  9		7	; slot9 = cout
		197	[251]	TGETS	  8	7	27	; slot8 = cout.pop
		198	[251]	CALL 	  8	2	2	; slot8 = cout.pop(cout)
		199	[253]	ISF  	   		8	; if not result
		200	[253]	JMP  	  9		126	; 	goto 327
		201	[254]	GGET 	  9		54	; slot9 = _env["unpack"]
		202	[254]	MOV  	 10		8	; slot10 = result
		203	[254]	CALL 	  9	6	2	; slot9, slot10, slot11, slot12, slot13 = unpack(result)
		204	[255]	ISNES	  9		26	; if r1 ~= "DONE"
		205	[255]	JMP  	 14		6	; 	goto 212
		206	[257]	GGET 	 14		56	; slot14 = _env["table"]
		207	[257]	TGETS	 14	14	55	; slot14 = table.remove
		208	[257]	TGETS	 15	0	62	; slot15 = self.threads
		209	[257]	MOV  	 16		4	; slot16 = i
		210	[257]	CALL 	 14	1	3	;  = table.remove(self.threads, i)
		211	[257]	JMP  	 14		115	; 	goto 327
		212	[258]	ISNES	  9		25	; if r1 ~= "ERROR"
		213	[258]	JMP  	 14		7	; 	goto 221
		214	[259]	UGET 	 14		0	; slot14 = uv0"log"
		215	[259]	TGETS	 14	14	24	; slot14 = uv0"log".error
		216	[259]	KSTR 	 15		23	; slot15 = "Failed to load image file: %s. Error: %s"
		217	[259]	MOV  	 16		11	; slot16 = r3
		218	[259]	MOV  	 17		10	; slot17 = r2
		219	[259]	CALL 	 14	1	4	;  = uv0"log".error(slot15, r3, r2)
		220	[259]	JMP  	 14		106	; 	goto 327
		221	[260]	ISNES	  9		22	; if r1 ~= "OK"
		222	[260]	JMP  	 14		104	; 	goto 327
		223	[262]	MOV  	 14		10	; slot14 = r2
		224	[262]	MOV  	 15		11	; slot15 = r3
		225	[262]	MOV  	 16		12	; slot16 = r4
		226	[262]	MOV  	 17		13	; slot17 = r5
		227	[263]	UGET 	 18		4	; slot18 = uv4"G"
		228	[263]	TGETS	 18	18	21	; slot18 = uv4"G".newImage
		229	[263]	MOV  	 19		15	; slot19 = data
		230	[263]	CALL 	 18	2	2	; slot18 = uv4"G".newImage(data)
		231	[264]	IST  	   		18	; if im
		232	[264]	JMP  	 19		6	; 	goto 239
		233	[265]	UGET 	 19		0	; slot19 = uv0"log"
		234	[265]	TGETS	 19	19	24	; slot19 = uv0"log".error
		235	[265]	KSTR 	 20		20	; slot20 = "Image could not be created: %s"
		236	[265]	MOV  	 21		14	; slot21 = key
		237	[265]	CALL 	 19	1	3	;  = uv0"log".error(slot20, key)
		238	[265]	JMP  	 19		88	; 	goto 327
		239	[267]	TGETS	 19	0	19	; slot19 = self.use_canvas
		240	[267]	ISF  	   		19	; if not self.use_canvas
		241	[267]	JMP  	 20		46	; 	goto 288
		242	[267]	MOV  	 20		18	; slot20 = im
		243	[267]	TGETS	 19	18	18	; slot19 = im.isCompressed
		244	[267]	CALL 	 19	2	2	; slot19 = im.isCompressed(im)
		245	[267]	IST  	   		19	; if im.isCompressed
		246	[267]	JMP  	 19		41	; 	goto 288
		247	[268]	UGET 	 19		0	; slot19 = uv0"log"
		248	[268]	TGETS	 19	19	38	; slot19 = uv0"log".paranoid
		249	[268]	KSTR 	 20		17	; slot20 = " +++ creating canvas %s"
		250	[268]	MOV  	 21		18	; slot21 = im
		251	[268]	CALL 	 19	1	3	;  = uv0"log".paranoid(slot20, im)
		252	[269]	UGET 	 19		4	; slot19 = uv4"G"
		253	[269]	TGETS	 19	19	16	; slot19 = uv4"G".newCanvas
		254	[269]	MOV  	 20		16	; slot20 = w
		255	[269]	MOV  	 21		17	; slot21 = h
		256	[269]	CALL 	 19	2	3	; slot19 = uv4"G".newCanvas(w, h)
		257	[270]	UGET 	 20		4	; slot20 = uv4"G"
		258	[270]	TGETS	 20	20	15	; slot20 = uv4"G".setCanvas
		259	[270]	MOV  	 21		19	; slot21 = c
		260	[270]	CALL 	 20	1	2	;  = uv4"G".setCanvas(c)
		261	[271]	UGET 	 20		4	; slot20 = uv4"G"
		262	[271]	TGETS	 20	20	14	; slot20 = uv4"G".setBlendMode
		263	[271]	KSTR 	 21		13	; slot21 = "replace"
		264	[271]	KSTR 	 22		12	; slot22 = "premultiplied"
		265	[271]	CALL 	 20	1	3	;  = uv4"G".setBlendMode(slot21, slot22)
		266	[272]	UGET 	 20		4	; slot20 = uv4"G"
		267	[272]	TGETS	 20	20	11	; slot20 = uv4"G".draw
		268	[272]	MOV  	 21		18	; slot21 = im
		269	[272]	CALL 	 20	1	2	;  = uv4"G".draw(im)
		270	[273]	UGET 	 20		4	; slot20 = uv4"G"
		271	[273]	TGETS	 20	20	14	; slot20 = uv4"G".setBlendMode
		272	[273]	KSTR 	 21		10	; slot21 = "alpha"
		273	[273]	KSTR 	 22		9	; slot22 = "alphamultiply"
		274	[273]	CALL 	 20	1	3	;  = uv4"G".setBlendMode(slot21, slot22)
		275	[274]	UGET 	 20		4	; slot20 = uv4"G"
		276	[274]	TGETS	 20	20	15	; slot20 = uv4"G".setCanvas
		277	[274]	CALL 	 20	1	1	;  = uv4"G".setCanvas()
		278	[275]	TGETS	 20	0	8	; slot20 = self.db_images
		279	[275]	TNEW 	 21		4	; slot21 = new table( array: 4, dict: 1)
		280	[275]	TSETB	 19	21	1	; slot21[1] = c
		281	[275]	TSETB	 16	21	2	; slot21[2] = w
		282	[275]	TSETB	 17	21	3	; slot21[3] = h
		283	[275]	TSETV	 21	20	14	; self.db_images[key] = slot21
		284	[276]	KPRI 	 18		0	; slot18 = nil
		285	[277]	GGET 	 20		7	; slot20 = _env["collectgarbage"]
		286	[277]	CALL 	 20	1	1	;  = collectgarbage()
		287	[277]	JMP  	 19		22	; 	goto 310
		288	[279]	UGET 	 19		0	; slot19 = uv0"log"
		289	[279]	TGETS	 19	19	38	; slot19 = uv0"log".paranoid
		290	[279]	KSTR 	 20		6	; slot20 = " +++ keeping image %s"
		291	[279]	MOV  	 21		18	; slot21 = im
		292	[279]	CALL 	 19	1	3	;  = uv0"log".paranoid(slot20, im)
		293	[280]	TGETS	 19	0	8	; slot19 = self.db_images
		294	[280]	TNEW 	 20		4	; slot20 = new table( array: 4, dict: 1)
		295	[280]	TSETB	 18	20	1	; slot20[1] = im
		296	[280]	TSETB	 16	20	2	; slot20[2] = w
		297	[280]	TSETB	 17	20	3	; slot20[3] = h
		298	[280]	TSETV	 20	19	14	; self.db_images[key] = slot20
		299	[281]	MOV  	 20		18	; slot20 = im
		300	[281]	TGETS	 19	18	18	; slot19 = im.isCompressed
		301	[281]	CALL 	 19	2	2	; slot19 = im.isCompressed(im)
		302	[281]	ISF  	   		19	; if not im.isCompressed
		303	[281]	JMP  	 20		6	; 	goto 310
		304	[281]	TGETS	 19	0	5	; slot19 = self.release_compressed_data
		305	[281]	ISF  	   		19	; if not self.release_compressed_data
		306	[281]	JMP  	 20		3	; 	goto 310
		307	[284]	MOV  	 20		18	; slot20 = im
		308	[284]	TGETS	 19	18	4	; slot19 = im.kReleaseCompressedData
		309	[284]	CALL 	 19	1	2	;  = im.kReleaseCompressedData(im)
		310	[287]	TGETS	 19	0	3	; slot19 = self.queue_load_done_images
		311	[287]	ADDVN	 19	19	1	; slot19 = self.queue_load_done_images + 1
		312	[287]	TSETS	 19	0	3	; self.queue_load_done_images = slot19
		313	[290]	JMP  	  8		13	; 	goto 327
		314	[292]	UGET 	  8		0	; slot8 = uv0"log"
		315	[292]	TGETS	  8	8	24	; slot8 = uv0"log".error
		316	[292]	KSTR 	  9		2	; slot9 = "Thread %s error:%s"
		317	[292]	MOV  	 10		4	; slot10 = i
		318	[292]	MOV  	 12		5	; slot12 = th
		319	[292]	TGETS	 11	5	1	; slot11 = th.getError
		320	[292]	CALL 	 11	0	2	; MULTRES = th.getError(th)
		321	[292]	CALLM	  8	1	2	;  = uv0"log".error(slot9, i, ...MULTRES)
		322	[293]	GGET 	  8		56	; slot8 = _env["table"]
		323	[293]	TGETS	  8	8	55	; slot8 = table.remove
		324	[293]	TGETS	  9	0	62	; slot9 = self.threads
		325	[293]	MOV  	 10		4	; slot10 = i
		326	[293]	CALL 	  8	1	3	;  = table.remove(self.threads, i)
		327	[248]	FORL 	  1		-141	; slot4 = slot4 + slot3<step>; if cmp(slot4, sign slot3<step>,  slot2<limit>) goto 187
		328	[298]	TGETS	  1	0	62	; slot1 = self.threads
		329	[298]	LEN  	  1		1	; slot1 = #self.threads
		330	[298]	KSHORT	  2		0	; slot2 = 0
		331	[298]	ISGE 	  2		1	; if slot2 >= slot1
		332	[298]	JMP  	  1		6	; 	goto 339
		333	[299]	TGETS	  1	0	3	; slot1 = self.queue_load_done_images
		334	[299]	TGETS	  2	0	49	; slot2 = self.queue_load_total_images
		335	[299]	DIVVV	  1	1	2	; slot1 = self.queue_load_done_images / self.queue_load_total_images
		336	[299]	TSETS	  1	0	61	; self.progress = slot1
		337	[300]	KPRI 	  1		1	; slot1 = false
		338	[300]	RET1 	  1		2	; return slot1
		339	[304]	TGETS	  1	0	63	; slot1 = self.load_queue
		340	[304]	LEN  	  1		1	; slot1 = #self.load_queue
		341	[304]	KSHORT	  2		0	; slot2 = 0
		342	[304]	ISGE 	  2		1	; if slot2 >= slot1
		343	[304]	JMP  	  1		1	; 	goto 345
		344	[305]	JMP  	  1		-321	; 	goto 24
		345	[309]	UGET 	  1		0	; slot1 = uv0"log"
		346	[309]	TGETS	  1	1	0	; slot1 = uv0"log".end_time
		347	[309]	KSTR 	  2		57	; slot2 = "textures"
		348	[309]	CALL 	  1	1	2	;  = uv0"log".end_time(slot2)
		349	[310]	KPRI 	  1		0	; slot1 = nil
		350	[310]	TSETS	  1	0	59	; self.queue_load_start_time = slot1
		351	[311]	KSHORT	  1		1	; slot1 = 1
		352	[311]	TSETS	  1	0	61	; self.progress = slot1
		353	[312]	KSHORT	  1		0	; slot1 = 0
		354	[312]	TSETS	  1	0	60	; self.groups_total = slot1
		355	[313]	KSHORT	  1		0	; slot1 = 0
		356	[313]	TSETS	  1	0	49	; self.queue_load_total_images = slot1
		357	[314]	KSHORT	  1		0	; slot1 = 0
		358	[314]	TSETS	  1	0	3	; self.queue_load_done_images = slot1
		359	[315]	TNEW 	  1		0	; slot1 = new table( array: 0, dict: 1)
		360	[315]	TSETS	  1	0	50	; self.image_name_queue = slot1
		361	[316]	KPRI 	  1		2	; slot1 = true
		362	[316]	RET1 	  1		2	; return slot1
	 72	[175]	TSETS	  8	4	30	; image_db.queue_load_done = slot8
	 73	[327]	FNEW 	  8		27	; @./lib/klove/image_db.lua:319-327: 4 args, 1 upvalues, 9 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-30:	self
		  0-30:	ref_scale
		  0-30:	path
		  0-30:	name
		;;;; instructions ;;;;
		  1	[320]	UGET 	  4		0	; slot4 = uv0"log"
		  2	[320]	TGETS	  4	4	8	; slot4 = uv0"log".debug
		  3	[320]	KSTR 	  5		7	; slot5 = "queued %s/%s-%.6f"
		  4	[320]	MOV  	  6		2	; slot6 = path
		  5	[320]	MOV  	  7		3	; slot7 = name
		  6	[320]	MOV  	  8		1	; slot8 = ref_scale
		  7	[320]	CALL 	  4	1	5	;  = uv0"log".debug(slot5, path, name, ref_scale)
		  8	[321]	GGET 	  4		6	; slot4 = _env["table"]
		  9	[321]	TGETS	  4	4	5	; slot4 = table.insert
		 10	[321]	TGETS	  5	0	4	; slot5 = self.load_queue
		 11	[321]	TNEW 	  6		4	; slot6 = new table( array: 4, dict: 1)
		 12	[321]	TSETB	  1	6	1	; slot6[1] = ref_scale
		 13	[321]	TSETB	  2	6	2	; slot6[2] = path
		 14	[321]	TSETB	  3	6	3	; slot6[3] = name
		 15	[321]	CALL 	  4	1	3	;  = table.insert(self.load_queue, slot6)
		 16	[322]	TGETS	  4	0	3	; slot4 = self.groups_total
		 17	[322]	ADDVN	  4	4	0	; slot4 = self.groups_total + 1
		 18	[322]	TSETS	  4	0	3	; self.groups_total = slot4
		 19	[323]	TGETS	  4	0	4	; slot4 = self.load_queue
		 20	[323]	LEN  	  4		4	; slot4 = #self.load_queue
		 21	[323]	ISNEN	  4		0	; if slot4 ~= 1
		 22	[323]	JMP  	  4		7	; 	goto 30
		 23	[323]	TGETS	  4	0	2	; slot4 = self.load_queue_current
		 24	[323]	IST  	   		4	; if self.load_queue_current
		 25	[323]	JMP  	  4		4	; 	goto 30
		 26	[324]	KSHORT	  4		0	; slot4 = 0
		 27	[324]	TSETS	  4	0	1	; self.progress = slot4
		 28	[325]	KSHORT	  4		0	; slot4 = 0
		 29	[325]	TSETS	  4	0	0	; self.groups_done = slot4
		 30	[327]	RET0 	  0		1	; return
	 74	[319]	TSETS	  8	4	28	; image_db.queue_load_atlas = slot8
	 75	[361]	FNEW 	  8		25	; @./lib/klove/image_db.lua:329-361: 3 args, 1 upvalues, 14 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-93:	self
		  0-93:	name
		  0-93:	ref_scale
		  9-93:	name_scale
		  45-93:	remove_frames
		  46-93:	remove_images
		  49-63:	<generator>
		  49-63:	<state>
		  49-63:	<control>
		  50-61:	k
		  50-61:	f
		  64-93:	removed_images_count
		  67-74:	<generator>
		  67-74:	<state>
		  67-74:	<control>
		  68-72:	k
		  68-72:	_
		  77-83:	<generator>
		  77-83:	<state>
		  77-83:	<control>
		  78-81:	_
		  78-81:	k
		;;;; instructions ;;;;
		  1	[330]	IST  	   		2	; if ref_scale
		  2	[330]	JMP  	  3		1	; 	goto 4
		  3	[330]	KSHORT	  2		1	; slot2 = 1
		  4	[331]	GGET 	  3		17	; slot3 = _env["string"]
		  5	[331]	TGETS	  3	3	16	; slot3 = string.format
		  6	[331]	KSTR 	  4		15	; slot4 = "%s-%.6f"
		  7	[331]	MOV  	  5		1	; slot5 = name
		  8	[331]	MOV  	  6		2	; slot6 = ref_scale
		  9	[331]	CALL 	  3	2	4	; slot3 = string.format(slot4, name, ref_scale)
		 10	[332]	TGETS	  4	0	14	; slot4 = self.atlas_uses
		 11	[332]	TGETV	  4	4	3	; slot4 = self.atlas_uses[name_scale]
		 12	[332]	IST  	   		4	; if slot4
		 13	[332]	JMP  	  4		6	; 	goto 20
		 14	[333]	UGET 	  4		0	; slot4 = uv0"log"
		 15	[333]	TGETS	  4	4	13	; slot4 = uv0"log".info
		 16	[333]	KSTR 	  5		12	; slot5 = "atlas %s does not exist"
		 17	[333]	MOV  	  6		3	; slot6 = name_scale
		 18	[333]	CALL 	  4	1	3	;  = uv0"log".info(slot5, name_scale)
		 19	[334]	RET0 	  0		1	; return
		 20	[336]	TGETS	  4	0	14	; slot4 = self.atlas_uses
		 21	[336]	TGETS	  5	0	14	; slot5 = self.atlas_uses
		 22	[336]	TGETV	  5	5	3	; slot5 = self.atlas_uses[name_scale]
		 23	[336]	SUBVN	  5	5	0	; slot5 = slot5 - 1
		 24	[336]	TSETV	  5	4	3	; self.atlas_uses[name_scale] = slot5
		 25	[337]	TGETS	  4	0	14	; slot4 = self.atlas_uses
		 26	[337]	TGETV	  4	4	3	; slot4 = self.atlas_uses[name_scale]
		 27	[337]	KSHORT	  5		0	; slot5 = 0
		 28	[337]	ISGE 	  5		4	; if slot5 >= slot4
		 29	[337]	JMP  	  4		6	; 	goto 36
		 30	[338]	UGET 	  4		0	; slot4 = uv0"log"
		 31	[338]	TGETS	  4	4	11	; slot4 = uv0"log".debug
		 32	[338]	KSTR 	  5		10	; slot5 = "atlas %s still in use"
		 33	[338]	MOV  	  6		1	; slot6 = name
		 34	[338]	CALL 	  4	1	3	;  = uv0"log".debug(slot5, name)
		 35	[339]	RET0 	  0		1	; return
		 36	[341]	UGET 	  4		0	; slot4 = uv0"log"
		 37	[341]	TGETS	  4	4	11	; slot4 = uv0"log".debug
		 38	[341]	KSTR 	  5		9	; slot5 = "unloading atlas %s-%.6f"
		 39	[341]	MOV  	  6		1	; slot6 = name
		 40	[341]	MOV  	  7		2	; slot7 = ref_scale
		 41	[341]	CALL 	  4	1	4	;  = uv0"log".debug(slot5, name, ref_scale)
		 42	[342]	TGETS	  4	0	14	; slot4 = self.atlas_uses
		 43	[342]	KPRI 	  5		0	; slot5 = nil
		 44	[342]	TSETV	  5	4	3	; self.atlas_uses[name_scale] = slot5
		 45	[343]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
		 46	[344]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		 47	[345]	GGET 	  6		8	; slot6 = _env["pairs"]
		 48	[345]	TGETS	  7	0	7	; slot7 = self.db_atlas
		 49	[345]	CALL 	  6	4	2	; slot6, slot7, slot8 = pairs(self.db_atlas)
		 50	[345]	ISNEXT	  9		11	; Verify ITERN at 62; goto 62
		 51	[346]	TGETS	 11	10	6	; slot11 = f.group
		 52	[346]	ISNEV	 11		3	; if f.group ~= name_scale
		 53	[346]	JMP  	 11		8	; 	goto 62
		 54	[347]	GGET 	 11		5	; slot11 = _env["table"]
		 55	[347]	TGETS	 11	11	4	; slot11 = table.insert
		 56	[347]	MOV  	 12		4	; slot12 = remove_frames
		 57	[347]	MOV  	 13		9	; slot13 = k
		 58	[347]	CALL 	 11	1	3	;  = table.insert(remove_frames, k)
		 59	[348]	TGETS	 11	10	3	; slot11 = f.atlas
		 60	[348]	KPRI 	 12		2	; slot12 = true
		 61	[348]	TSETV	 12	5	11	; remove_images[f.atlas] = slot12
		 62	[345]	ITERN	  9	3	3	; slot9, slot10, slot11 = slot6<generator>, slot7<state>, slot8<control>; slot9, slot10 = slot6<generator>(slot7<state>, slot8<control>)
		 63	[345]	ITERL	  9		-13	; slot8<control> = slot9; if slot9 != nil goto 51
		 64	[351]	KSHORT	  6		0	; slot6 = 0
		 65	[352]	GGET 	  7		8	; slot7 = _env["pairs"]
		 66	[352]	MOV  	  8		5	; slot8 = remove_images
		 67	[352]	CALL 	  7	4	2	; slot7, slot8, slot9 = pairs(remove_images)
		 68	[352]	ISNEXT	 10		4	; Verify ITERN at 73; goto 73
		 69	[353]	TGETS	 12	0	2	; slot12 = self.db_images
		 70	[353]	KPRI 	 13		0	; slot13 = nil
		 71	[353]	TSETV	 13	12	10	; self.db_images[k] = slot13
		 72	[354]	ADDVN	  6	6	0	; slot6 = removed_images_count + 1
		 73	[352]	ITERN	 10	3	3	; slot10, slot11, slot12 = slot7<generator>, slot8<state>, slot9<control>; slot10, slot11 = slot7<generator>(slot8<state>, slot9<control>)
		 74	[352]	ITERL	 10		-6	; slot9<control> = slot10; if slot10 != nil goto 69
		 75	[356]	GGET 	  7		8	; slot7 = _env["pairs"]
		 76	[356]	MOV  	  8		4	; slot8 = remove_frames
		 77	[356]	CALL 	  7	4	2	; slot7, slot8, slot9 = pairs(remove_frames)
		 78	[356]	ISNEXT	 10		3	; Verify ITERN at 82; goto 82
		 79	[357]	TGETS	 12	0	7	; slot12 = self.db_atlas
		 80	[357]	KPRI 	 13		0	; slot13 = nil
		 81	[357]	TSETV	 13	12	11	; self.db_atlas[k] = slot13
		 82	[356]	ITERN	 10	3	3	; slot10, slot11, slot12 = slot7<generator>, slot8<state>, slot9<control>; slot10, slot11 = slot7<generator>(slot8<state>, slot9<control>)
		 83	[356]	ITERL	 10		-5	; slot9<control> = slot10; if slot10 != nil goto 79
		 84	[359]	UGET 	  7		0	; slot7 = uv0"log"
		 85	[359]	TGETS	  7	7	11	; slot7 = uv0"log".debug
		 86	[359]	KSTR 	  8		1	; slot8 = " removed #frames:%s #images:%s "
		 87	[359]	LEN  	  9		4	; slot9 = #remove_frames
		 88	[359]	MOV  	 10		6	; slot10 = removed_images_count
		 89	[359]	CALL 	  7	1	4	;  = uv0"log".debug(slot8, slot9, removed_images_count)
		 90	[360]	MOV  	  8		0	; slot8 = self
		 91	[360]	TGETS	  7	0	0	; slot7 = self.purge_atlas
		 92	[360]	CALL 	  7	1	2	;  = self.purge_atlas(self)
		 93	[361]	RET0 	  0		1	; return
	 76	[329]	TSETS	  8	4	26	; image_db.unload_atlas = slot8
	 77	[380]	FNEW 	  8		23	; @./lib/klove/image_db.lua:363-380: 1 args, 1 upvalues, 11 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-40:	self
		  1-40:	used_images
		  4-10:	<generator>
		  4-10:	<state>
		  4-10:	<control>
		  5-8:	k
		  5-8:	f
		  11-40:	remove_images
		  14-25:	<generator>
		  14-25:	<state>
		  14-25:	<control>
		  15-23:	k
		  15-23:	v
		  28-34:	<generator>
		  28-34:	<state>
		  28-34:	<control>
		  29-32:	_
		  29-32:	v
		;;;; instructions ;;;;
		  1	[366]	TNEW 	  1		0	; slot1 = new table( array: 0, dict: 1)
		  2	[367]	GGET 	  2		7	; slot2 = _env["pairs"]
		  3	[367]	TGETS	  3	0	6	; slot3 = self.db_atlas
		  4	[367]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(self.db_atlas)
		  5	[367]	ISNEXT	  5		3	; Verify ITERN at 9; goto 9
		  6	[368]	TGETS	  7	6	5	; slot7 = f.atlas
		  7	[368]	KPRI 	  8		2	; slot8 = true
		  8	[368]	TSETV	  8	1	7	; used_images[f.atlas] = slot8
		  9	[367]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		 10	[367]	ITERL	  5		-5	; slot4<control> = slot5; if slot5 != nil goto 6
		 11	[370]	TNEW 	  2		0	; slot2 = new table( array: 0, dict: 1)
		 12	[371]	GGET 	  3		7	; slot3 = _env["pairs"]
		 13	[371]	TGETS	  4	0	4	; slot4 = self.db_images
		 14	[371]	CALL 	  3	4	2	; slot3, slot4, slot5 = pairs(self.db_images)
		 15	[371]	ISNEXT	  6		8	; Verify ITERN at 24; goto 24
		 16	[372]	TGETV	  8	1	6	; slot8 = used_images[k]
		 17	[372]	IST  	   		8	; if slot8
		 18	[372]	JMP  	  8		5	; 	goto 24
		 19	[373]	GGET 	  8		3	; slot8 = _env["table"]
		 20	[373]	TGETS	  8	8	2	; slot8 = table.insert
		 21	[373]	MOV  	  9		2	; slot9 = remove_images
		 22	[373]	MOV  	 10		6	; slot10 = k
		 23	[373]	CALL 	  8	1	3	;  = table.insert(remove_images, k)
		 24	[371]	ITERN	  6	3	3	; slot6, slot7, slot8 = slot3<generator>, slot4<state>, slot5<control>; slot6, slot7 = slot3<generator>(slot4<state>, slot5<control>)
		 25	[371]	ITERL	  6		-10	; slot5<control> = slot6; if slot6 != nil goto 16
		 26	[376]	GGET 	  3		7	; slot3 = _env["pairs"]
		 27	[376]	MOV  	  4		2	; slot4 = remove_images
		 28	[376]	CALL 	  3	4	2	; slot3, slot4, slot5 = pairs(remove_images)
		 29	[376]	ISNEXT	  6		3	; Verify ITERN at 33; goto 33
		 30	[377]	TGETS	  8	0	4	; slot8 = self.db_images
		 31	[377]	KPRI 	  9		0	; slot9 = nil
		 32	[377]	TSETV	  9	8	7	; self.db_images[v] = slot9
		 33	[376]	ITERN	  6	3	3	; slot6, slot7, slot8 = slot3<generator>, slot4<state>, slot5<control>; slot6, slot7 = slot3<generator>(slot4<state>, slot5<control>)
		 34	[376]	ITERL	  6		-5	; slot5<control> = slot6; if slot6 != nil goto 30
		 35	[379]	UGET 	  3		0	; slot3 = uv0"log"
		 36	[379]	TGETS	  3	3	1	; slot3 = uv0"log".debug
		 37	[379]	KSTR 	  4		0	; slot4 = "  purged #images:%s"
		 38	[379]	LEN  	  5		2	; slot5 = #remove_images
		 39	[379]	CALL 	  3	1	3	;  = uv0"log".debug(slot4, slot5)
		 40	[380]	RET0 	  0		1	; return
	 78	[363]	TSETS	  8	4	24	; image_db.purge_atlas = slot8
	 79	[446]	FNEW 	  8		21	; @./lib/klove/image_db.lua:383-446: 4 args, 3 upvalues, 22 slots
		
		;;;; constant tables ;;;;
		ktable#0 = [
			]
		
		
		;;;; upvalue names ;;;;
		  0:	log
		  1:	FS
		  2:	G
		;;;; variable info ;;;;
		  0-230:	self
		  0-230:	ref_scale
		  0-230:	path
		  0-230:	name
		  6-230:	name_scale
		  46-230:	group_file
		  65-230:	frames
		  66-230:	unique_frames
		  67-230:	image_names
		  68-230:	deferred_image_names
		  71-157:	<generator>
		  71-157:	<state>
		  71-157:	<control>
		  72-155:	k
		  72-155:	v
		  150-154:	<generator>
		  150-154:	<state>
		  150-154:	<control>
		  151-152:	_
		  151-152:	a
		  160-164:	<generator>
		  160-164:	<state>
		  160-164:	<control>
		  161-162:	k
		  161-162:	v
		  173-229:	<generator>
		  173-229:	<state>
		  173-229:	<control>
		  174-227:	fn
		  180-227:	key
		;;;; instructions ;;;;
		  1	[384]	GGET 	  4		44	; slot4 = _env["string"]
		  2	[384]	TGETS	  4	4	43	; slot4 = string.format
		  3	[384]	KSTR 	  5		42	; slot5 = "%s-%.6f"
		  4	[384]	MOV  	  6		3	; slot6 = name
		  5	[384]	MOV  	  7		1	; slot7 = ref_scale
		  6	[384]	CALL 	  4	2	4	; slot4 = string.format(slot5, name, ref_scale)
		  7	[385]	UGET 	  5		0	; slot5 = uv0"log"
		  8	[385]	TGETS	  5	5	41	; slot5 = uv0"log".debug
		  9	[385]	KSTR 	  6		40	; slot6 = "load atlas: %s,%s-%.6f"
		 10	[385]	MOV  	  7		2	; slot7 = path
		 11	[385]	MOV  	  8		3	; slot8 = name
		 12	[385]	MOV  	  9		1	; slot9 = ref_scale
		 13	[385]	CALL 	  5	1	5	;  = uv0"log".debug(slot6, path, name, ref_scale)
		 14	[386]	TGETS	  5	0	39	; slot5 = self.atlas_uses
		 15	[386]	TGETV	  5	5	4	; slot5 = self.atlas_uses[name_scale]
		 16	[386]	ISF  	   		5	; if not slot5
		 17	[386]	JMP  	  6		11	; 	goto 29
		 18	[387]	TGETS	  5	0	39	; slot5 = self.atlas_uses
		 19	[387]	TGETS	  6	0	39	; slot6 = self.atlas_uses
		 20	[387]	TGETV	  6	6	4	; slot6 = self.atlas_uses[name_scale]
		 21	[387]	ADDVN	  6	6	0	; slot6 = slot6 + 1
		 22	[387]	TSETV	  6	5	4	; self.atlas_uses[name_scale] = slot6
		 23	[388]	UGET 	  5		0	; slot5 = uv0"log"
		 24	[388]	TGETS	  5	5	41	; slot5 = uv0"log".debug
		 25	[388]	KSTR 	  6		38	; slot6 = "atlas %s already loaded"
		 26	[388]	MOV  	  7		3	; slot7 = name
		 27	[388]	CALL 	  5	1	3	;  = uv0"log".debug(slot6, name)
		 28	[389]	RET0 	  0		1	; return
		 29	[391]	TGETS	  5	0	39	; slot5 = self.atlas_uses
		 30	[391]	KSHORT	  6		1	; slot6 = 1
		 31	[391]	TSETV	  6	5	4	; self.atlas_uses[name_scale] = slot6
		 32	[392]	GGET 	  5		37	; slot5 = _env["table"]
		 33	[392]	TGETS	  5	5	36	; slot5 = table.insert
		 34	[392]	TGETS	  6	0	35	; slot6 = self.last_preloaded_group_names
		 35	[392]	MOV  	  7		3	; slot7 = name
		 36	[392]	CALL 	  5	1	3	;  = table.insert(self.last_preloaded_group_names, name)
		 37	[394]	KSHORT	  5		0	; slot5 = 0
		 38	[394]	TSETS	  5	0	34	; self.progress = slot5
		 39	[395]	IST  	   		1	; if ref_scale
		 40	[395]	JMP  	  5		1	; 	goto 42
		 41	[395]	KSHORT	  1		1	; slot1 = 1
		 42	[397]	MOV  	  5		2	; slot5 = path
		 43	[397]	KSTR 	  6		33	; slot6 = "/"
		 44	[397]	MOV  	  7		3	; slot7 = name
		 45	[397]	KSTR 	  8		32	; slot8 = ".lua"
		 46	[397]	CAT  	  5	5	8	; slot5 = path .. slot6 .. name .. slot8
		 47	[398]	UGET 	  6		1	; slot6 = uv1"FS"
		 48	[398]	TGETS	  6	6	31	; slot6 = uv1"FS".isFile
		 49	[398]	MOV  	  7		5	; slot7 = group_file
		 50	[398]	CALL 	  6	2	2	; slot6 = uv1"FS".isFile(group_file)
		 51	[398]	IST  	   		6	; if uv1"FS".isFile
		 52	[398]	JMP  	  6		8	; 	goto 61
		 53	[399]	UGET 	  6		0	; slot6 = uv0"log"
		 54	[399]	TGETS	  6	6	30	; slot6 = uv0"log".error
		 55	[399]	KSTR 	  7		29	; slot7 = "atlas file %s not found for %s/%s"
		 56	[399]	MOV  	  8		5	; slot8 = group_file
		 57	[399]	MOV  	  9		2	; slot9 = path
		 58	[399]	MOV  	 10		3	; slot10 = name
		 59	[399]	CALL 	  6	1	5	;  = uv0"log".error(slot7, group_file, path, name)
		 60	[400]	RET0 	  0		1	; return
		 61	[402]	UGET 	  6		1	; slot6 = uv1"FS"
		 62	[402]	TGETS	  6	6	28	; slot6 = uv1"FS".load
		 63	[402]	MOV  	  7		5	; slot7 = group_file
		 64	[402]	CALL 	  6	2	2	; slot6 = uv1"FS".load(group_file)
		 65	[402]	CALL 	  6	2	1	; slot6 = uv1"FS".load()
		 66	[403]	TNEW 	  7		0	; slot7 = new table( array: 0, dict: 1)
		 67	[404]	TNEW 	  8		0	; slot8 = new table( array: 0, dict: 1)
		 68	[405]	TNEW 	  9		0	; slot9 = new table( array: 0, dict: 1)
		 69	[407]	GGET 	 10		27	; slot10 = _env["pairs"]
		 70	[407]	MOV  	 11		6	; slot11 = frames
		 71	[407]	CALL 	 10	4	2	; slot10, slot11, slot12 = pairs(frames)
		 72	[407]	ISNEXT	 13		83	; Verify ITERN at 156; goto 156
		 73	[408]	UGET 	 15		0	; slot15 = uv0"log"
		 74	[408]	TGETS	 15	15	26	; slot15 = uv0"log".paranoid
		 75	[408]	KSTR 	 16		25	; slot16 = "loading atlas-frame: %s - %s"
		 76	[408]	TGETS	 17	14	24	; slot17 = v.a_name
		 77	[408]	MOV  	 18		13	; slot18 = k
		 78	[408]	CALL 	 15	1	4	;  = uv0"log".paranoid(slot16, v.a_name, k)
		 79	[409]	TSETS	  4	14	23	; v.group = name_scale
		 80	[410]	UGET 	 15		2	; slot15 = uv2"G"
		 81	[410]	TGETS	 15	15	21	; slot15 = uv2"G".newQuad
		 82	[410]	TGETS	 16	14	20	; slot16 = v.f_quad
		 83	[410]	TGETB	 16	16	1	; slot16 = v.f_quad[1]
		 84	[410]	TGETS	 17	14	20	; slot17 = v.f_quad
		 85	[410]	TGETB	 17	17	2	; slot17 = v.f_quad[2]
		 86	[410]	TGETS	 18	14	20	; slot18 = v.f_quad
		 87	[410]	TGETB	 18	18	3	; slot18 = v.f_quad[3]
		 88	[410]	TGETS	 19	14	20	; slot19 = v.f_quad
		 89	[410]	TGETB	 19	19	4	; slot19 = v.f_quad[4]
		 90	[410]	TGETS	 20	14	19	; slot20 = v.a_size
		 91	[410]	TGETB	 20	20	1	; slot20 = v.a_size[1]
		 92	[410]	TGETS	 21	14	19	; slot21 = v.a_size
		 93	[410]	TGETB	 21	21	2	; slot21 = v.a_size[2]
		 94	[410]	CALL 	 15	2	7	; slot15 = uv2"G".newQuad(slot16, slot17, slot18, slot19, slot20, slot21)
		 95	[410]	TSETS	 15	14	22	; v.quad = uv2"G".newQuad
		 96	[411]	TGETS	 15	14	18	; slot15 = v.defer
		 97	[411]	ISF  	   		15	; if not v.defer
		 98	[411]	JMP  	 16		4	; 	goto 103
		 99	[412]	TGETS	 15	14	24	; slot15 = v.a_name
		100	[412]	KPRI 	 16		2	; slot16 = true
		101	[412]	TSETV	 16	9	15	; deferred_image_names[v.a_name] = slot16
		102	[412]	JMP  	 15		3	; 	goto 106
		103	[414]	TGETS	 15	14	24	; slot15 = v.a_name
		104	[414]	KPRI 	 16		2	; slot16 = true
		105	[414]	TSETV	 16	8	15	; image_names[v.a_name] = slot16
		106	[416]	GGET 	 15		44	; slot15 = _env["string"]
		107	[416]	TGETS	 15	15	16	; slot15 = string.gsub
		108	[416]	TGETS	 16	14	24	; slot16 = v.a_name
		109	[416]	KSTR 	 17		15	; slot17 = ".png$"
		110	[416]	KSTR 	 18		14	; slot18 = ""
		111	[416]	CALL 	 15	2	4	; slot15 = string.gsub(v.a_name, slot17, slot18)
		112	[416]	TSETS	 15	14	17	; v.atlas = string.gsub
		113	[417]	GGET 	 15		44	; slot15 = _env["string"]
		114	[417]	TGETS	 15	15	16	; slot15 = string.gsub
		115	[417]	TGETS	 16	14	17	; slot16 = v.atlas
		116	[417]	KSTR 	 17		13	; slot17 = ".lz4$"
		117	[417]	KSTR 	 18		14	; slot18 = ""
		118	[417]	CALL 	 15	2	4	; slot15 = string.gsub(v.atlas, slot17, slot18)
		119	[417]	TSETS	 15	14	17	; v.atlas = string.gsub
		120	[418]	GGET 	 15		44	; slot15 = _env["string"]
		121	[418]	TGETS	 15	15	16	; slot15 = string.gsub
		122	[418]	TGETS	 16	14	17	; slot16 = v.atlas
		123	[418]	KSTR 	 17		12	; slot17 = ".pkm$"
		124	[418]	KSTR 	 18		14	; slot18 = ""
		125	[418]	CALL 	 15	2	4	; slot15 = string.gsub(v.atlas, slot17, slot18)
		126	[418]	TSETS	 15	14	17	; v.atlas = string.gsub
		127	[419]	GGET 	 15		44	; slot15 = _env["string"]
		128	[419]	TGETS	 15	15	16	; slot15 = string.gsub
		129	[419]	TGETS	 16	14	17	; slot16 = v.atlas
		130	[419]	KSTR 	 17		11	; slot17 = ".ktx$"
		131	[419]	KSTR 	 18		14	; slot18 = ""
		132	[419]	CALL 	 15	2	4	; slot15 = string.gsub(v.atlas, slot17, slot18)
		133	[419]	TSETS	 15	14	17	; v.atlas = string.gsub
		134	[420]	GGET 	 15		44	; slot15 = _env["string"]
		135	[420]	TGETS	 15	15	16	; slot15 = string.gsub
		136	[420]	TGETS	 16	14	17	; slot16 = v.atlas
		137	[420]	KSTR 	 17		10	; slot17 = ".astc$"
		138	[420]	KSTR 	 18		14	; slot18 = ""
		139	[420]	CALL 	 15	2	4	; slot15 = string.gsub(v.atlas, slot17, slot18)
		140	[420]	TSETS	 15	14	17	; v.atlas = string.gsub
		141	[421]	GGET 	 15		44	; slot15 = _env["string"]
		142	[421]	TGETS	 15	15	16	; slot15 = string.gsub
		143	[421]	TGETS	 16	14	17	; slot16 = v.atlas
		144	[421]	KSTR 	 17		9	; slot17 = ".dds"
		145	[421]	KSTR 	 18		14	; slot18 = ""
		146	[421]	CALL 	 15	2	4	; slot15 = string.gsub(v.atlas, slot17, slot18)
		147	[421]	TSETS	 15	14	17	; v.atlas = string.gsub
		148	[422]	GGET 	 15		8	; slot15 = _env["ipairs"]
		149	[422]	TGETS	 16	14	7	; slot16 = v.alias
		150	[422]	CALL 	 15	4	2	; slot15, slot16, slot17 = ipairs(v.alias)
		151	[422]	JMP  	 18		1	; 	goto 153
		152	[423]	TSETV	 14	7	19	; unique_frames[a] = v
		153	[422]	ITERC	 18	3	3	; slot18, slot19, slot20 = slot15<generator>, slot16<state>, slot17<control>; slot18, slot19 = slot15<generator>(slot16<state>, slot17<control>)
		154	[422]	ITERL	 18		-3	; slot17<control> = slot18; if slot18 != nil goto 152
		155	[425]	TSETS	  1	14	6	; v.ref_scale = ref_scale
		156	[407]	ITERN	 13	3	3	; slot13, slot14, slot15 = slot10<generator>, slot11<state>, slot12<control>; slot13, slot14 = slot10<generator>(slot11<state>, slot12<control>)
		157	[407]	ITERL	 13		-85	; slot12<control> = slot13; if slot13 != nil goto 73
		158	[428]	GGET 	 10		27	; slot10 = _env["pairs"]
		159	[428]	MOV  	 11		7	; slot11 = unique_frames
		160	[428]	CALL 	 10	4	2	; slot10, slot11, slot12 = pairs(unique_frames)
		161	[428]	ISNEXT	 13		1	; Verify ITERN at 163; goto 163
		162	[429]	TSETV	 14	6	13	; frames[k] = v
		163	[428]	ITERN	 13	3	3	; slot13, slot14, slot15 = slot10<generator>, slot11<state>, slot12<control>; slot13, slot14 = slot10<generator>(slot11<state>, slot12<control>)
		164	[428]	ITERL	 13		-3	; slot12<control> = slot13; if slot13 != nil goto 162
		165	[431]	GGET 	 10		37	; slot10 = _env["table"]
		166	[431]	TGETS	 10	10	4	; slot10 = table.merge
		167	[431]	TGETS	 11	0	5	; slot11 = self.db_atlas
		168	[431]	MOV  	 12		6	; slot12 = frames
		169	[431]	CALL 	 10	2	3	; slot10 = table.merge(self.db_atlas, frames)
		170	[431]	TSETS	 10	0	5	; self.db_atlas = table.merge
		171	[434]	GGET 	 10		27	; slot10 = _env["pairs"]
		172	[434]	MOV  	 11		9	; slot11 = deferred_image_names
		173	[434]	CALL 	 10	4	2	; slot10, slot11, slot12 = pairs(deferred_image_names)
		174	[434]	ISNEXT	 13		53	; Verify ITERN at 228; goto 228
		175	[435]	GGET 	 14		44	; slot14 = _env["string"]
		176	[435]	TGETS	 14	14	16	; slot14 = string.gsub
		177	[435]	MOV  	 15		13	; slot15 = fn
		178	[435]	KSTR 	 16		15	; slot16 = ".png$"
		179	[435]	KSTR 	 17		14	; slot17 = ""
		180	[435]	CALL 	 14	2	4	; slot14 = string.gsub(fn, slot16, slot17)
		181	[436]	GGET 	 15		44	; slot15 = _env["string"]
		182	[436]	TGETS	 15	15	16	; slot15 = string.gsub
		183	[436]	MOV  	 16		14	; slot16 = key
		184	[436]	KSTR 	 17		13	; slot17 = ".lz4$"
		185	[436]	KSTR 	 18		14	; slot18 = ""
		186	[436]	CALL 	 15	2	4	; slot15 = string.gsub(key, slot17, slot18)
		187	[436]	MOV  	 14		15	; slot14 = string.gsub
		188	[437]	GGET 	 15		44	; slot15 = _env["string"]
		189	[437]	TGETS	 15	15	16	; slot15 = string.gsub
		190	[437]	MOV  	 16		14	; slot16 = key
		191	[437]	KSTR 	 17		3	; slot17 = ".jpg$"
		192	[437]	KSTR 	 18		14	; slot18 = ""
		193	[437]	CALL 	 15	2	4	; slot15 = string.gsub(key, slot17, slot18)
		194	[437]	MOV  	 14		15	; slot14 = string.gsub
		195	[438]	GGET 	 15		44	; slot15 = _env["string"]
		196	[438]	TGETS	 15	15	16	; slot15 = string.gsub
		197	[438]	MOV  	 16		14	; slot16 = key
		198	[438]	KSTR 	 17		12	; slot17 = ".pkm$"
		199	[438]	KSTR 	 18		14	; slot18 = ""
		200	[438]	CALL 	 15	2	4	; slot15 = string.gsub(key, slot17, slot18)
		201	[438]	MOV  	 14		15	; slot14 = string.gsub
		202	[439]	GGET 	 15		44	; slot15 = _env["string"]
		203	[439]	TGETS	 15	15	16	; slot15 = string.gsub
		204	[439]	MOV  	 16		14	; slot16 = key
		205	[439]	KSTR 	 17		11	; slot17 = ".ktx$"
		206	[439]	KSTR 	 18		14	; slot18 = ""
		207	[439]	CALL 	 15	2	4	; slot15 = string.gsub(key, slot17, slot18)
		208	[439]	MOV  	 14		15	; slot14 = string.gsub
		209	[440]	GGET 	 15		44	; slot15 = _env["string"]
		210	[440]	TGETS	 15	15	16	; slot15 = string.gsub
		211	[440]	MOV  	 16		14	; slot16 = key
		212	[440]	KSTR 	 17		10	; slot17 = ".astc$"
		213	[440]	KSTR 	 18		14	; slot18 = ""
		214	[440]	CALL 	 15	2	4	; slot15 = string.gsub(key, slot17, slot18)
		215	[440]	MOV  	 14		15	; slot14 = string.gsub
		216	[441]	GGET 	 15		44	; slot15 = _env["string"]
		217	[441]	TGETS	 15	15	16	; slot15 = string.gsub
		218	[441]	MOV  	 16		14	; slot16 = key
		219	[441]	KSTR 	 17		2	; slot17 = ".dds$"
		220	[441]	KSTR 	 18		14	; slot18 = ""
		221	[441]	CALL 	 15	2	4	; slot15 = string.gsub(key, slot17, slot18)
		222	[441]	MOV  	 14		15	; slot14 = string.gsub
		223	[442]	TGETS	 15	0	1	; slot15 = self.db_images
		224	[442]	TDUP 	 16		0	; slot16 = copy table#k0
		225	[442]	TSETB	 13	16	4	; slot16[4] = fn
		226	[442]	TSETB	  2	16	5	; slot16[5] = path
		227	[442]	TSETV	 16	15	14	; self.db_images[key] = slot16
		228	[434]	ITERN	 13	2	3	; slot13, slot14, slot15 = slot10<generator>, slot11<state>, slot12<control>; slot13 = slot10<generator>(slot11<state>, slot12<control>)
		229	[434]	ITERL	 13		-55	; slot12<control> = slot13; if slot13 != nil goto 175
		230	[445]	RET1 	  8		2	; return image_names
	 80	[383]	TSETS	  8	4	22	; image_db.preload_atlas = slot8
	 81	[466]	FNEW 	  8		19	; @./lib/klove/image_db.lua:448-466: 5 args, 2 upvalues, 18 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	image_db
		  1:	log
		;;;; variable info ;;;;
		  0-60:	self
		  0-60:	ref_scale
		  0-60:	path
		  0-60:	name
		  0-60:	yielding
		  4-60:	rt_start
		  10-60:	image_names
		  14-60:	i
		  17-45:	<generator>
		  17-45:	<state>
		  17-45:	<control>
		  18-43:	fn
		  25-43:	key
		  25-43:	im
		  25-43:	w
		  25-43:	h
		;;;; instructions ;;;;
		  1	[449]	GGET 	  5		13	; slot5 = _env["love"]
		  2	[449]	TGETS	  5	5	12	; slot5 = love.timer
		  3	[449]	TGETS	  5	5	11	; slot5 = love.timer.getTime
		  4	[449]	CALL 	  5	2	1	; slot5 = love.timer.getTime()
		  5	[451]	MOV  	  7		0	; slot7 = self
		  6	[451]	TGETS	  6	0	10	; slot6 = self.preload_atlas
		  7	[451]	MOV  	  8		1	; slot8 = ref_scale
		  8	[451]	MOV  	  9		2	; slot9 = path
		  9	[451]	MOV  	 10		3	; slot10 = name
		 10	[451]	CALL 	  6	2	5	; slot6 = self.preload_atlas(self, ref_scale, path, name)
		 11	[452]	IST  	   		6	; if image_names
		 12	[452]	JMP  	  7		1	; 	goto 14
		 13	[452]	RET0 	  0		1	; return
		 14	[454]	KSHORT	  7		0	; slot7 = 0
		 15	[455]	GGET 	  8		9	; slot8 = _env["pairs"]
		 16	[455]	MOV  	  9		6	; slot9 = image_names
		 17	[455]	CALL 	  8	4	2	; slot8, slot9, slot10 = pairs(image_names)
		 18	[455]	ISNEXT	 11		25	; Verify ITERN at 44; goto 44
		 19	[456]	ADDVN	  7	7	0	; slot7 = i + 1
		 20	[457]	UGET 	 12		0	; slot12 = uv0"image_db"
		 21	[457]	MOV  	 13		12	; slot13 = uv0"image_db"
		 22	[457]	TGETS	 12	12	8	; slot12 = uv0"image_db".load_image_file
		 23	[457]	MOV  	 14		11	; slot14 = fn
		 24	[457]	MOV  	 15		2	; slot15 = path
		 25	[457]	CALL 	 12	5	4	; slot12, slot13, slot14, slot15 = uv0"image_db".load_image_file(uv0"image_db", fn, path)
		 26	[458]	TGETS	 16	0	7	; slot16 = self.db_images
		 27	[458]	TNEW 	 17		4	; slot17 = new table( array: 4, dict: 1)
		 28	[458]	TSETB	 13	17	1	; slot17[1] = im
		 29	[458]	TSETB	 14	17	2	; slot17[2] = w
		 30	[458]	TSETB	 15	17	3	; slot17[3] = h
		 31	[458]	TSETV	 17	16	12	; self.db_images[key] = slot17
		 32	[459]	ISF  	   		4	; if not yielding
		 33	[459]	JMP  	 16		10	; 	goto 44
		 34	[460]	GGET 	 16		5	; slot16 = _env["table"]
		 35	[460]	TGETS	 16	16	4	; slot16 = table.keys
		 36	[460]	MOV  	 17		6	; slot17 = image_names
		 37	[460]	CALL 	 16	2	2	; slot16 = table.keys(image_names)
		 38	[460]	LEN  	 16		16	; slot16 = #table.keys
		 39	[460]	DIVVV	 16	7	16	; slot16 = i / slot16
		 40	[460]	TSETS	 16	0	6	; self.progress = slot16
		 41	[461]	GGET 	 16		3	; slot16 = _env["coroutine"]
		 42	[461]	TGETS	 16	16	2	; slot16 = coroutine.yield
		 43	[461]	CALL 	 16	1	1	;  = coroutine.yield()
		 44	[455]	ITERN	 11	2	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11 = slot8<generator>(slot9<state>, slot10<control>)
		 45	[455]	ITERL	 11		-27	; slot10<control> = slot11; if slot11 != nil goto 19
		 46	[464]	KSHORT	  8		1	; slot8 = 1
		 47	[464]	TSETS	  8	0	6	; self.progress = slot8
		 48	[465]	UGET 	  8		1	; slot8 = uv1"log"
		 49	[465]	TGETS	  8	8	1	; slot8 = uv1"log".info
		 50	[465]	KSTR 	  9		0	; slot9 = "Finished loading atlas %s/%s at scale %s (time:%s)"
		 51	[465]	MOV  	 10		2	; slot10 = path
		 52	[465]	MOV  	 11		3	; slot11 = name
		 53	[465]	MOV  	 12		1	; slot12 = ref_scale
		 54	[465]	GGET 	 13		13	; slot13 = _env["love"]
		 55	[465]	TGETS	 13	13	12	; slot13 = love.timer
		 56	[465]	TGETS	 13	13	11	; slot13 = love.timer.getTime
		 57	[465]	CALL 	 13	2	1	; slot13 = love.timer.getTime()
		 58	[465]	SUBVV	 13	13	5	; slot13 = love.timer.getTime - rt_start
		 59	[465]	CALL 	  8	1	6	;  = uv1"log".info(slot9, path, name, ref_scale, slot13)
		 60	[466]	RET0 	  0		1	; return
	 82	[448]	TSETS	  8	4	20	; image_db.load_atlas = slot8
	 83	[531]	FNEW 	  8		17	; @./lib/klove/image_db.lua:471-531: 3 args, 3 upvalues, 32 slots
		
		;;;; constant tables ;;;;
		ktable#32 = [
			#1: images/ipad,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	FS
		  1:	G
		  2:	log
		;;;; variable info ;;;;
		  0-182:	self
		  0-182:	ref_scale
		  0-182:	custom_paths
		  6-182:	paths
		  7-182:	image_files
		  10-81:	<generator>
		  10-81:	<state>
		  10-81:	<control>
		  11-79:	_
		  11-79:	path
		  15-79:	files
		  18-79:	<index>
		  18-79:	<limit>
		  18-79:	<step>
		  19-78:	i
		  20-78:	name
		  24-78:	f
		  50-78:	key
		  61-78:	im
		  72-78:	w
		  72-78:	h
		  84-177:	<generator>
		  84-177:	<state>
		  84-177:	<control>
		  85-175:	_
		  85-175:	path
		  89-175:	files
		  92-175:	<index>
		  92-175:	<limit>
		  92-175:	<step>
		  93-174:	i
		  94-174:	name
		  98-174:	f
		  117-174:	file_basename
		  123-174:	frames
		  124-174:	queue
		  127-161:	<generator>
		  127-161:	<state>
		  127-161:	<control>
		  128-159:	k
		  128-159:	v
		  154-158:	<generator>
		  154-158:	<state>
		  154-158:	<control>
		  155-156:	_
		  155-156:	a
		  164-168:	<generator>
		  164-168:	<state>
		  164-168:	<control>
		  165-166:	k
		  165-166:	v
		;;;; instructions ;;;;
		  1	[472]	IST  	   		1	; if ref_scale
		  2	[472]	JMP  	  3		1	; 	goto 4
		  3	[472]	KSHORT	  1		1	; slot1 = 1
		  4	[473]	ISTC 	  3		2	; slot3 = custom_paths; if custom_paths
		  5	[473]	JMP  	  3		1	; 	goto 7
		  6	[473]	TDUP 	  3		32	; slot3 = copy table#k32
		  7	[474]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
		  8	[477]	GGET 	  5		31	; slot5 = _env["pairs"]
		  9	[477]	MOV  	  6		3	; slot6 = paths
		 10	[477]	CALL 	  5	4	2	; slot5, slot6, slot7 = pairs(paths)
		 11	[477]	ISNEXT	  8		68	; Verify ITERN at 80; goto 80
		 12	[478]	UGET 	 10		0	; slot10 = uv0"FS"
		 13	[478]	TGETS	 10	10	30	; slot10 = uv0"FS".getDirectoryItems
		 14	[478]	MOV  	 11		9	; slot11 = path
		 15	[478]	CALL 	 10	2	2	; slot10 = uv0"FS".getDirectoryItems(path)
		 16	[479]	KSHORT	 11		1	; slot11 = 1
		 17	[479]	LEN  	 12		10	; slot12 = #files
		 18	[479]	KSHORT	 13		1	; slot13 = 1
		 19	[479]	FORI 	 11		60	; for slot14 = slot11,slot12,slot13 else goto 80
		 20	[480]	TGETV	 15	10	14	; slot15 = files[i]
		 21	[481]	MOV  	 16		9	; slot16 = path
		 22	[481]	KSTR 	 17		29	; slot17 = "/"
		 23	[481]	MOV  	 18		15	; slot18 = name
		 24	[481]	CAT  	 16	16	18	; slot16 = path .. slot17 .. name
		 25	[482]	UGET 	 17		0	; slot17 = uv0"FS"
		 26	[482]	TGETS	 17	17	28	; slot17 = uv0"FS".isFile
		 27	[482]	MOV  	 18		16	; slot18 = f
		 28	[482]	CALL 	 17	2	2	; slot17 = uv0"FS".isFile(f)
		 29	[482]	ISF  	   		17	; if not uv0"FS".isFile
		 30	[482]	JMP  	 18		48	; 	goto 79
		 31	[482]	GGET 	 17		27	; slot17 = _env["string"]
		 32	[482]	TGETS	 17	17	26	; slot17 = string.match
		 33	[482]	MOV  	 18		16	; slot18 = f
		 34	[482]	KSTR 	 19		25	; slot19 = ".png$"
		 35	[482]	CALL 	 17	2	3	; slot17 = string.match(f, slot19)
		 36	[482]	IST  	   		17	; if string.match
		 37	[482]	JMP  	 18		7	; 	goto 45
		 38	[482]	GGET 	 17		27	; slot17 = _env["string"]
		 39	[482]	TGETS	 17	17	26	; slot17 = string.match
		 40	[482]	MOV  	 18		16	; slot18 = f
		 41	[482]	KSTR 	 19		24	; slot19 = ".jpg$"
		 42	[482]	CALL 	 17	2	3	; slot17 = string.match(f, slot19)
		 43	[482]	ISF  	   		17	; if not string.match
		 44	[482]	JMP  	 18		34	; 	goto 79
		 45	[484]	GGET 	 17		27	; slot17 = _env["string"]
		 46	[484]	TGETS	 17	17	23	; slot17 = string.gsub
		 47	[484]	MOV  	 18		15	; slot18 = name
		 48	[484]	KSTR 	 19		25	; slot19 = ".png$"
		 49	[484]	KSTR 	 20		22	; slot20 = ""
		 50	[484]	CALL 	 17	2	4	; slot17 = string.gsub(name, slot19, slot20)
		 51	[485]	GGET 	 18		27	; slot18 = _env["string"]
		 52	[485]	TGETS	 18	18	23	; slot18 = string.gsub
		 53	[485]	MOV  	 19		17	; slot19 = key
		 54	[485]	KSTR 	 20		24	; slot20 = ".jpg$"
		 55	[485]	KSTR 	 21		22	; slot21 = ""
		 56	[485]	CALL 	 18	2	4	; slot18 = string.gsub(key, slot20, slot21)
		 57	[485]	MOV  	 17		18	; slot17 = string.gsub
		 58	[486]	UGET 	 18		1	; slot18 = uv1"G"
		 59	[486]	TGETS	 18	18	21	; slot18 = uv1"G".newImage
		 60	[486]	MOV  	 19		16	; slot19 = f
		 61	[486]	CALL 	 18	2	2	; slot18 = uv1"G".newImage(f)
		 62	[487]	IST  	   		18	; if im
		 63	[487]	JMP  	 19		6	; 	goto 70
		 64	[488]	UGET 	 19		2	; slot19 = uv2"log"
		 65	[488]	TGETS	 19	19	20	; slot19 = uv2"log".error
		 66	[488]	KSTR 	 20		19	; slot20 = "Image %s could not be created"
		 67	[488]	MOV  	 21		16	; slot21 = f
		 68	[488]	CALL 	 19	1	3	;  = uv2"log".error(slot20, f)
		 69	[488]	JMP  	 19		9	; 	goto 79
		 70	[490]	MOV  	 20		18	; slot20 = im
		 71	[490]	TGETS	 19	18	18	; slot19 = im.getDimensions
		 72	[490]	CALL 	 19	3	2	; slot19, slot20 = im.getDimensions(im)
		 73	[491]	TGETS	 21	0	17	; slot21 = self.db_images
		 74	[491]	TNEW 	 22		4	; slot22 = new table( array: 4, dict: 1)
		 75	[491]	TSETB	 18	22	1	; slot22[1] = im
		 76	[491]	TSETB	 19	22	2	; slot22[2] = w
		 77	[491]	TSETB	 20	22	3	; slot22[3] = h
		 78	[491]	TSETV	 22	21	17	; self.db_images[key] = slot22
		 79	[479]	FORL 	 11		-60	; slot14 = slot14 + slot13<step>; if cmp(slot14, sign slot13<step>,  slot12<limit>) goto 20
		 80	[477]	ITERN	  8	3	3	; slot8, slot9, slot10 = slot5<generator>, slot6<state>, slot7<control>; slot8, slot9 = slot5<generator>(slot6<state>, slot7<control>)
		 81	[477]	ITERL	  8		-70	; slot7<control> = slot8; if slot8 != nil goto 12
		 82	[499]	GGET 	  5		31	; slot5 = _env["pairs"]
		 83	[499]	MOV  	  6		3	; slot6 = paths
		 84	[499]	CALL 	  5	4	2	; slot5, slot6, slot7 = pairs(paths)
		 85	[499]	ISNEXT	  8		90	; Verify ITERN at 176; goto 176
		 86	[500]	UGET 	 10		0	; slot10 = uv0"FS"
		 87	[500]	TGETS	 10	10	30	; slot10 = uv0"FS".getDirectoryItems
		 88	[500]	MOV  	 11		9	; slot11 = path
		 89	[500]	CALL 	 10	2	2	; slot10 = uv0"FS".getDirectoryItems(path)
		 90	[501]	KSHORT	 11		1	; slot11 = 1
		 91	[501]	LEN  	 12		10	; slot12 = #files
		 92	[501]	KSHORT	 13		1	; slot13 = 1
		 93	[501]	FORI 	 11		82	; for slot14 = slot11,slot12,slot13 else goto 176
		 94	[502]	TGETV	 15	10	14	; slot15 = files[i]
		 95	[503]	MOV  	 16		9	; slot16 = path
		 96	[503]	KSTR 	 17		29	; slot17 = "/"
		 97	[503]	MOV  	 18		15	; slot18 = name
		 98	[503]	CAT  	 16	16	18	; slot16 = path .. slot17 .. name
		 99	[504]	UGET 	 17		0	; slot17 = uv0"FS"
		100	[504]	TGETS	 17	17	28	; slot17 = uv0"FS".isFile
		101	[504]	MOV  	 18		16	; slot18 = f
		102	[504]	CALL 	 17	2	2	; slot17 = uv0"FS".isFile(f)
		103	[504]	ISF  	   		17	; if not uv0"FS".isFile
		104	[504]	JMP  	 18		70	; 	goto 175
		105	[504]	GGET 	 17		27	; slot17 = _env["string"]
		106	[504]	TGETS	 17	17	26	; slot17 = string.match
		107	[504]	MOV  	 18		16	; slot18 = f
		108	[504]	KSTR 	 19		16	; slot19 = ".lua$"
		109	[504]	CALL 	 17	2	3	; slot17 = string.match(f, slot19)
		110	[504]	ISF  	   		17	; if not string.match
		111	[504]	JMP  	 18		63	; 	goto 175
		112	[505]	GGET 	 17		27	; slot17 = _env["string"]
		113	[505]	TGETS	 17	17	23	; slot17 = string.gsub
		114	[505]	MOV  	 18		15	; slot18 = name
		115	[505]	KSTR 	 19		16	; slot19 = ".lua$"
		116	[505]	KSTR 	 20		22	; slot20 = ""
		117	[505]	CALL 	 17	2	4	; slot17 = string.gsub(name, slot19, slot20)
		118	[506]	GGET 	 18		15	; slot18 = _env["require"]
		119	[506]	MOV  	 19		9	; slot19 = path
		120	[506]	KSTR 	 20		14	; slot20 = "."
		121	[506]	MOV  	 21		17	; slot21 = file_basename
		122	[506]	CAT  	 19	19	21	; slot19 = path .. slot20 .. file_basename
		123	[506]	CALL 	 18	2	2	; slot18 = require(slot19)
		124	[507]	TNEW 	 19		0	; slot19 = new table( array: 0, dict: 1)
		125	[509]	GGET 	 20		31	; slot20 = _env["pairs"]
		126	[509]	MOV  	 21		18	; slot21 = frames
		127	[509]	CALL 	 20	4	2	; slot20, slot21, slot22 = pairs(frames)
		128	[509]	ISNEXT	 23		31	; Verify ITERN at 160; goto 160
		129	[511]	UGET 	 25		1	; slot25 = uv1"G"
		130	[511]	TGETS	 25	25	12	; slot25 = uv1"G".newQuad
		131	[511]	TGETS	 26	24	11	; slot26 = v.f_quad
		132	[511]	TGETB	 26	26	1	; slot26 = v.f_quad[1]
		133	[511]	TGETS	 27	24	11	; slot27 = v.f_quad
		134	[511]	TGETB	 27	27	2	; slot27 = v.f_quad[2]
		135	[511]	TGETS	 28	24	11	; slot28 = v.f_quad
		136	[511]	TGETB	 28	28	3	; slot28 = v.f_quad[3]
		137	[511]	TGETS	 29	24	11	; slot29 = v.f_quad
		138	[511]	TGETB	 29	29	4	; slot29 = v.f_quad[4]
		139	[511]	TGETS	 30	24	10	; slot30 = v.a_size
		140	[511]	TGETB	 30	30	1	; slot30 = v.a_size[1]
		141	[511]	TGETS	 31	24	10	; slot31 = v.a_size
		142	[511]	TGETB	 31	31	2	; slot31 = v.a_size[2]
		143	[511]	CALL 	 25	2	7	; slot25 = uv1"G".newQuad(slot26, slot27, slot28, slot29, slot30, slot31)
		144	[511]	TSETS	 25	24	13	; v.quad = uv1"G".newQuad
		145	[512]	GGET 	 25		27	; slot25 = _env["string"]
		146	[512]	TGETS	 25	25	23	; slot25 = string.gsub
		147	[512]	TGETS	 26	24	8	; slot26 = v.a_name
		148	[512]	KSTR 	 27		25	; slot27 = ".png$"
		149	[512]	KSTR 	 28		22	; slot28 = ""
		150	[512]	CALL 	 25	2	4	; slot25 = string.gsub(v.a_name, slot27, slot28)
		151	[512]	TSETS	 25	24	9	; v.atlas = string.gsub
		152	[513]	GGET 	 25		7	; slot25 = _env["ipairs"]
		153	[513]	TGETS	 26	24	6	; slot26 = v.alias
		154	[513]	CALL 	 25	4	2	; slot25, slot26, slot27 = ipairs(v.alias)
		155	[513]	JMP  	 28		1	; 	goto 157
		156	[514]	TSETV	 24	19	29	; queue[a] = v
		157	[513]	ITERC	 28	3	3	; slot28, slot29, slot30 = slot25<generator>, slot26<state>, slot27<control>; slot28, slot29 = slot25<generator>(slot26<state>, slot27<control>)
		158	[513]	ITERL	 28		-3	; slot27<control> = slot28; if slot28 != nil goto 156
		159	[516]	TSETS	  1	24	5	; v.ref_scale = ref_scale
		160	[509]	ITERN	 23	3	3	; slot23, slot24, slot25 = slot20<generator>, slot21<state>, slot22<control>; slot23, slot24 = slot20<generator>(slot21<state>, slot22<control>)
		161	[509]	ITERL	 23		-33	; slot22<control> = slot23; if slot23 != nil goto 129
		162	[519]	GGET 	 20		31	; slot20 = _env["pairs"]
		163	[519]	MOV  	 21		19	; slot21 = queue
		164	[519]	CALL 	 20	4	2	; slot20, slot21, slot22 = pairs(queue)
		165	[519]	ISNEXT	 23		1	; Verify ITERN at 167; goto 167
		166	[520]	TSETV	 24	18	23	; frames[k] = v
		167	[519]	ITERN	 23	3	3	; slot23, slot24, slot25 = slot20<generator>, slot21<state>, slot22<control>; slot23, slot24 = slot20<generator>(slot21<state>, slot22<control>)
		168	[519]	ITERL	 23		-3	; slot22<control> = slot23; if slot23 != nil goto 166
		169	[522]	GGET 	 20		3	; slot20 = _env["table"]
		170	[522]	TGETS	 20	20	2	; slot20 = table.merge
		171	[522]	TGETS	 21	0	4	; slot21 = self.db_atlas
		172	[522]	MOV  	 22		18	; slot22 = frames
		173	[522]	CALL 	 20	2	3	; slot20 = table.merge(self.db_atlas, frames)
		174	[522]	TSETS	 20	0	4	; self.db_atlas = table.merge
		175	[501]	FORL 	 11		-82	; slot14 = slot14 + slot13<step>; if cmp(slot14, sign slot13<step>,  slot12<limit>) goto 94
		176	[499]	ITERN	  8	3	3	; slot8, slot9, slot10 = slot5<generator>, slot6<state>, slot7<control>; slot8, slot9 = slot5<generator>(slot6<state>, slot7<control>)
		177	[499]	ITERL	  8		-92	; slot7<control> = slot8; if slot8 != nil goto 86
		178	[530]	UGET 	  5		2	; slot5 = uv2"log"
		179	[530]	TGETS	  5	5	1	; slot5 = uv2"log".debug
		180	[530]	KSTR 	  6		0	; slot6 = "finished loading image_db"
		181	[530]	CALL 	  5	1	2	;  = uv2"log".debug(slot6)
		182	[531]	RET0 	  0		1	; return
	 84	[471]	TSETS	  8	4	18	; image_db.load = slot8
	 85	[533]	GGET 	  8		16	; slot8 = _env["DEBUG"]
	 86	[533]	ISF  	   		8	; if not DEBUG
	 87	[533]	JMP  	  9		2	; 	goto 90
	 88	[599]	FNEW 	  8		14	; @./lib/klove/image_db.lua:544-599: 4 args, 1 upvalues, 30 slots
		
		;;;; constant tables ;;;;
		ktable#10 = [
			#1: 0,
			#2: 0,
			#3: 0,
			#4: 0,
			]
		
		
		ktable#33 = [
			#1: png,
			#2: pkm,
			#3: dds,
			#4: ktx,
			#5: jpg,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	G
		;;;; variable info ;;;;
		  0-108:	self
		  0-108:	ref_scale
		  0-108:	path
		  0-108:	group_name
		  9-108:	is_windows
		  14-108:	SEP
		  15-108:	image_formats
		  23-108:	name_scale
		  28-103:	<generator>
		  28-103:	<state>
		  28-103:	<control>
		  29-101:	_
		  29-101:	n
		  33-101:	fn
		  38-101:	fh
		  44-101:	fc
		  50-101:	fd
		  55-101:	id
		  59-101:	im
		  62-101:	w
		  62-101:	h
		  68-101:	key
		  69-101:	v
		;;;; instructions ;;;;
		  1	[545]	GGET 	  4		39	; slot4 = _env["love"]
		  2	[545]	TGETS	  4	4	38	; slot4 = love.system
		  3	[545]	TGETS	  4	4	37	; slot4 = love.system.getOS
		  4	[545]	CALL 	  4	2	1	; slot4 = love.system.getOS()
		  5	[545]	ISEQS	  4		36	; if love.system.getOS == "Windows"
		  6	[545]	JMP  	  4		2	; 	goto 9
		  7	[545]	KPRI 	  4		1	; slot4 = false
		  8	[545]	JMP  	  5		1	; 	goto 10
		  9	[545]	KPRI 	  4		2	; slot4 = true
		 10	[546]	ISF  	   		4	; if not is_windows
		 11	[546]	JMP  	  5		2	; 	goto 14
		 12	[546]	KSTR 	  5		35	; slot5 = "\"
		 13	[546]	JMP  	  6		1	; 	goto 15
		 14	[546]	KSTR 	  5		34	; slot5 = "/"
		 15	[547]	TDUP 	  6		33	; slot6 = copy table#k33
		 16	[569]	FNEW 	  7		32	; @./lib/klove/image_db.lua:549-569: 1 args, 2 upvalues, 16 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			  0:	is_windows
			  1:	image_formats
			;;;; variable info ;;;;
			  0-73:	path
			  1-73:	o
			  14-38:	<generator>
			  14-38:	<state>
			  14-38:	<control>
			  15-36:	n
			  18-36:	<generator>
			  18-36:	<state>
			  18-36:	<control>
			  19-34:	_
			  19-34:	k
			  48-72:	<generator>
			  48-72:	<state>
			  48-72:	<control>
			  49-70:	n
			  52-70:	<generator>
			  52-70:	<state>
			  52-70:	<control>
			  53-68:	_
			  53-68:	k
			;;;; instructions ;;;;
			  1	[550]	TNEW 	  1		0	; slot1 = new table( array: 0, dict: 1)
			  2	[551]	UGET 	  2		0	; slot2 = uv0"is_windows"
			  3	[551]	ISF  	   		2	; if not uv0"is_windows"
			  4	[551]	JMP  	  3		35	; 	goto 40
			  5	[552]	GGET 	  2		12	; slot2 = _env["io"]
			  6	[552]	TGETS	  2	2	11	; slot2 = io.popen
			  7	[552]	KSTR 	  3		10	; slot3 = "dir /b ""
			  8	[552]	MOV  	  4		0	; slot4 = path
			  9	[552]	KSTR 	  5		9	; slot5 = """
			 10	[552]	CAT  	  3	3	5	; slot3 = slot3 .. path .. slot5
			 11	[552]	CALL 	  2	2	2	; slot2 = io.popen(slot3)
			 12	[552]	MOV  	  3		2	; slot3 = slot2
			 13	[552]	TGETS	  2	2	8	; slot2 = slot2.lines
			 14	[552]	CALL 	  2	4	2	; slot2, slot3, slot4 = <unknown table>.lines(slot3)
			 15	[552]	JMP  	  5		21	; 	goto 37
			 16	[553]	GGET 	  6		7	; slot6 = _env["pairs"]
			 17	[553]	UGET 	  7		1	; slot7 = uv1"image_formats"
			 18	[553]	CALL 	  6	4	2	; slot6, slot7, slot8 = pairs(uv1"image_formats")
			 19	[553]	ISNEXT	  9		15	; Verify ITERN at 35; goto 35
			 20	[554]	GGET 	 11		6	; slot11 = _env["string"]
			 21	[554]	TGETS	 11	11	5	; slot11 = string.match
			 22	[554]	MOV  	 12		5	; slot12 = n
			 23	[554]	KSTR 	 13		4	; slot13 = ".+"
			 24	[554]	MOV  	 14		10	; slot14 = k
			 25	[554]	KSTR 	 15		3	; slot15 = "$"
			 26	[554]	CAT  	 13	13	15	; slot13 = slot13 .. k .. slot15
			 27	[554]	CALL 	 11	2	3	; slot11 = string.match(n, slot13)
			 28	[554]	ISF  	   		11	; if not string.match
			 29	[554]	JMP  	 12		5	; 	goto 35
			 30	[555]	GGET 	 11		2	; slot11 = _env["table"]
			 31	[555]	TGETS	 11	11	1	; slot11 = table.insert
			 32	[555]	MOV  	 12		1	; slot12 = o
			 33	[555]	MOV  	 13		5	; slot13 = n
			 34	[555]	CALL 	 11	1	3	;  = table.insert(o, n)
			 35	[553]	ITERN	  9	3	3	; slot9, slot10, slot11 = slot6<generator>, slot7<state>, slot8<control>; slot9, slot10 = slot6<generator>(slot7<state>, slot8<control>)
			 36	[553]	ITERL	  9		-17	; slot8<control> = slot9; if slot9 != nil goto 20
			 37	[552]	ITERC	  5	2	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5 = slot2<generator>(slot3<state>, slot4<control>)
			 38	[552]	ITERL	  5		-23	; slot4<control> = slot5; if slot5 != nil goto 16
			 39	[558]	JMP  	  2		33	; 	goto 73
			 40	[560]	GGET 	  2		12	; slot2 = _env["io"]
			 41	[560]	TGETS	  2	2	11	; slot2 = io.popen
			 42	[560]	KSTR 	  3		0	; slot3 = "ls "
			 43	[560]	MOV  	  4		0	; slot4 = path
			 44	[560]	CAT  	  3	3	4	; slot3 = slot3 .. path
			 45	[560]	CALL 	  2	2	2	; slot2 = io.popen(slot3)
			 46	[560]	MOV  	  3		2	; slot3 = slot2
			 47	[560]	TGETS	  2	2	8	; slot2 = slot2.lines
			 48	[560]	CALL 	  2	4	2	; slot2, slot3, slot4 = <unknown table>.lines(slot3)
			 49	[560]	JMP  	  5		21	; 	goto 71
			 50	[561]	GGET 	  6		7	; slot6 = _env["pairs"]
			 51	[561]	UGET 	  7		1	; slot7 = uv1"image_formats"
			 52	[561]	CALL 	  6	4	2	; slot6, slot7, slot8 = pairs(uv1"image_formats")
			 53	[561]	ISNEXT	  9		15	; Verify ITERN at 69; goto 69
			 54	[562]	GGET 	 11		6	; slot11 = _env["string"]
			 55	[562]	TGETS	 11	11	5	; slot11 = string.match
			 56	[562]	MOV  	 12		5	; slot12 = n
			 57	[562]	KSTR 	 13		4	; slot13 = ".+"
			 58	[562]	MOV  	 14		10	; slot14 = k
			 59	[562]	KSTR 	 15		3	; slot15 = "$"
			 60	[562]	CAT  	 13	13	15	; slot13 = slot13 .. k .. slot15
			 61	[562]	CALL 	 11	2	3	; slot11 = string.match(n, slot13)
			 62	[562]	ISF  	   		11	; if not string.match
			 63	[562]	JMP  	 12		5	; 	goto 69
			 64	[563]	GGET 	 11		2	; slot11 = _env["table"]
			 65	[563]	TGETS	 11	11	1	; slot11 = table.insert
			 66	[563]	MOV  	 12		1	; slot12 = o
			 67	[563]	MOV  	 13		5	; slot13 = n
			 68	[563]	CALL 	 11	1	3	;  = table.insert(o, n)
			 69	[561]	ITERN	  9	3	3	; slot9, slot10, slot11 = slot6<generator>, slot7<state>, slot8<control>; slot9, slot10 = slot6<generator>(slot7<state>, slot8<control>)
			 70	[561]	ITERL	  9		-17	; slot8<control> = slot9; if slot9 != nil goto 54
			 71	[560]	ITERC	  5	2	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5 = slot2<generator>(slot3<state>, slot4<control>)
			 72	[560]	ITERL	  5		-23	; slot4<control> = slot5; if slot5 != nil goto 50
			 73	[568]	RET1 	  1		2	; return o
		 17	[549]	GSET 	  7		31	; _env["ls"] = slot7
		 18	[571]	GGET 	  7		30	; slot7 = _env["string"]
		 19	[571]	TGETS	  7	7	29	; slot7 = string.format
		 20	[571]	KSTR 	  8		28	; slot8 = "%s-%.6f"
		 21	[571]	MOV  	  9		3	; slot9 = group_name
		 22	[571]	MOV  	 10		1	; slot10 = ref_scale
		 23	[571]	CALL 	  7	2	4	; slot7 = string.format(slot8, group_name, ref_scale)
		 24	[572]	GGET 	  8		27	; slot8 = _env["pairs"]
		 25	[572]	GGET 	  9		31	; slot9 = _env["ls"]
		 26	[572]	MOV  	 10		2	; slot10 = path
		 27	[572]	CALL 	  9	0	2	; MULTRES = ls(path)
		 28	[572]	CALLM	  8	4	0	; slot8, slot9, slot10 = pairs(, ...MULTRES)
		 29	[572]	ISNEXT	 11		72	; Verify ITERN at 102; goto 102
		 30	[573]	MOV  	 13		2	; slot13 = path
		 31	[573]	MOV  	 14		5	; slot14 = SEP
		 32	[573]	MOV  	 15		12	; slot15 = n
		 33	[573]	CAT  	 13	13	15	; slot13 = path .. SEP .. n
		 34	[574]	GGET 	 14		26	; slot14 = _env["io"]
		 35	[574]	TGETS	 14	14	25	; slot14 = io.open
		 36	[574]	MOV  	 15		13	; slot15 = fn
		 37	[574]	KSTR 	 16		24	; slot16 = "rb"
		 38	[574]	CALL 	 14	2	3	; slot14 = io.open(fn, slot16)
		 39	[575]	ISF  	   		14	; if not fh
		 40	[575]	JMP  	 15		61	; 	goto 102
		 41	[576]	MOV  	 16		14	; slot16 = fh
		 42	[576]	TGETS	 15	14	23	; slot15 = fh.read
		 43	[576]	KSTR 	 17		22	; slot17 = "*a"
		 44	[576]	CALL 	 15	2	3	; slot15 = fh.read(fh, slot17)
		 45	[577]	GGET 	 16		39	; slot16 = _env["love"]
		 46	[577]	TGETS	 16	16	21	; slot16 = love.filesystem
		 47	[577]	TGETS	 16	16	20	; slot16 = love.filesystem.newFileData
		 48	[577]	MOV  	 17		15	; slot17 = fc
		 49	[577]	MOV  	 18		12	; slot18 = n
		 50	[577]	CALL 	 16	2	3	; slot16 = love.filesystem.newFileData(fc, n)
		 51	[578]	GGET 	 17		39	; slot17 = _env["love"]
		 52	[578]	TGETS	 17	17	19	; slot17 = love.image
		 53	[578]	TGETS	 17	17	18	; slot17 = love.image.newImageData
		 54	[578]	MOV  	 18		16	; slot18 = fd
		 55	[578]	CALL 	 17	2	2	; slot17 = love.image.newImageData(fd)
		 56	[579]	UGET 	 18		0	; slot18 = uv0"G"
		 57	[579]	TGETS	 18	18	17	; slot18 = uv0"G".newImage
		 58	[579]	MOV  	 19		17	; slot19 = id
		 59	[579]	CALL 	 18	2	2	; slot18 = uv0"G".newImage(id)
		 60	[580]	MOV  	 20		18	; slot20 = im
		 61	[580]	TGETS	 19	18	16	; slot19 = im.getDimensions
		 62	[580]	CALL 	 19	3	2	; slot19, slot20 = im.getDimensions(im)
		 63	[581]	GGET 	 21		30	; slot21 = _env["string"]
		 64	[581]	TGETS	 21	21	15	; slot21 = string.gsub
		 65	[581]	MOV  	 22		12	; slot22 = n
		 66	[581]	KSTR 	 23		14	; slot23 = ".png$"
		 67	[581]	KSTR 	 24		13	; slot24 = ""
		 68	[581]	CALL 	 21	2	4	; slot21 = string.gsub(n, slot23, slot24)
		 69	[583]	TNEW 	 22		0	; slot22 = new table( array: 0, dict: 1)
		 70	[584]	TNEW 	 23		3	; slot23 = new table( array: 3, dict: 1)
		 71	[584]	TSETB	 19	23	1	; slot23[1] = w
		 72	[584]	TSETB	 20	23	2	; slot23[2] = h
		 73	[584]	TSETS	 23	22	12	; v.size = slot23
		 74	[585]	TDUP 	 23		10	; slot23 = copy table#k10
		 75	[585]	TSETS	 23	22	11	; v.trim = slot23
		 76	[586]	TSETS	 12	22	9	; v.a_name = n
		 77	[587]	TNEW 	 23		3	; slot23 = new table( array: 3, dict: 1)
		 78	[587]	TSETB	 19	23	1	; slot23[1] = w
		 79	[587]	TSETB	 20	23	2	; slot23[2] = h
		 80	[587]	TSETS	 23	22	8	; v.a_size = slot23
		 81	[588]	TSETS	  7	22	7	; v.group = name_scale
		 82	[589]	UGET 	 23		0	; slot23 = uv0"G"
		 83	[589]	TGETS	 23	23	5	; slot23 = uv0"G".newQuad
		 84	[589]	KSHORT	 24		0	; slot24 = 0
		 85	[589]	KSHORT	 25		0	; slot25 = 0
		 86	[589]	MOV  	 26		19	; slot26 = w
		 87	[589]	MOV  	 27		20	; slot27 = h
		 88	[589]	MOV  	 28		19	; slot28 = w
		 89	[589]	MOV  	 29		20	; slot29 = h
		 90	[589]	CALL 	 23	2	7	; slot23 = uv0"G".newQuad(slot24, slot25, w, h, w, h)
		 91	[589]	TSETS	 23	22	6	; v.quad = uv0"G".newQuad
		 92	[590]	TSETS	 21	22	4	; v.atlas = key
		 93	[591]	TSETS	  1	22	3	; v.ref_scale = ref_scale
		 94	[593]	TGETS	 23	0	2	; slot23 = self.db_atlas
		 95	[593]	TSETV	 22	23	21	; self.db_atlas[key] = v
		 96	[594]	TGETS	 23	0	1	; slot23 = self.db_images
		 97	[594]	TNEW 	 24		4	; slot24 = new table( array: 4, dict: 1)
		 98	[594]	TSETB	 18	24	1	; slot24[1] = im
		 99	[594]	TSETB	 19	24	2	; slot24[2] = w
		100	[594]	TSETB	 20	24	3	; slot24[3] = h
		101	[594]	TSETV	 24	23	21	; self.db_images[key] = slot24
		102	[572]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		103	[572]	ITERL	 11		-74	; slot10<control> = slot11; if slot11 != nil goto 30
		104	[597]	TGETS	  8	0	0	; slot8 = self.atlas_uses
		105	[597]	KSHORT	  9		1	; slot9 = 1
		106	[597]	TSETV	  9	8	7	; self.atlas_uses[name_scale] = slot9
		107	[599]	UCLO 	  0		0	; nil uvs >= r0; goto 108
		108	[599]	RET0 	  0		1	; return
	 89	[544]	TSETS	  8	4	15	; image_db.load_from_dir = slot8
	 90	[662]	FNEW 	  8		12	; @./lib/klove/image_db.lua:604-662: 3 args, 3 upvalues, 13 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	FS
		  1:	log
		  2:	G
		;;;; variable info ;;;;
		  0-252:	self
		  0-252:	fn
		  0-252:	path
		  4-252:	f
		  71-251:	compressed
		  104-114:	supportedformats
		  127-137:	supportedformats
		  150-160:	supportedformats
		  161-251:	im
		  168-181:	imd
		  198-251:	w
		  198-251:	h
		  204-251:	key
		;;;; instructions ;;;;
		  1	[605]	MOV  	  3		2	; slot3 = path
		  2	[605]	KSTR 	  4		33	; slot4 = "/"
		  3	[605]	MOV  	  5		1	; slot5 = fn
		  4	[605]	CAT  	  3	3	5	; slot3 = path .. slot4 .. fn
		  5	[606]	UGET 	  4		0	; slot4 = uv0"FS"
		  6	[606]	TGETS	  4	4	32	; slot4 = uv0"FS".isFile
		  7	[606]	MOV  	  5		3	; slot5 = f
		  8	[606]	CALL 	  4	2	2	; slot4 = uv0"FS".isFile(f)
		  9	[606]	IST  	   		4	; if uv0"FS".isFile
		 10	[606]	JMP  	  4		6	; 	goto 17
		 11	[607]	UGET 	  4		1	; slot4 = uv1"log"
		 12	[607]	TGETS	  4	4	31	; slot4 = uv1"log".error
		 13	[607]	KSTR 	  5		30	; slot5 = "not a valid file: %s"
		 14	[607]	MOV  	  6		3	; slot6 = f
		 15	[607]	CALL 	  4	1	3	;  = uv1"log".error(slot5, f)
		 16	[608]	RET0 	  0		1	; return
		 17	[610]	GGET 	  4		29	; slot4 = _env["string"]
		 18	[610]	TGETS	  4	4	28	; slot4 = string.match
		 19	[610]	MOV  	  5		3	; slot5 = f
		 20	[610]	KSTR 	  6		27	; slot6 = ".png$"
		 21	[610]	CALL 	  4	2	3	; slot4 = string.match(f, slot6)
		 22	[610]	IST  	   		4	; if string.match
		 23	[610]	JMP  	  5		42	; 	goto 66
		 24	[610]	GGET 	  4		29	; slot4 = _env["string"]
		 25	[610]	TGETS	  4	4	28	; slot4 = string.match
		 26	[610]	MOV  	  5		3	; slot5 = f
		 27	[610]	KSTR 	  6		26	; slot6 = ".jpg$"
		 28	[610]	CALL 	  4	2	3	; slot4 = string.match(f, slot6)
		 29	[610]	IST  	   		4	; if string.match
		 30	[610]	JMP  	  5		35	; 	goto 66
		 31	[610]	GGET 	  4		29	; slot4 = _env["string"]
		 32	[610]	TGETS	  4	4	28	; slot4 = string.match
		 33	[610]	MOV  	  5		3	; slot5 = f
		 34	[610]	KSTR 	  6		25	; slot6 = ".pkm$"
		 35	[610]	CALL 	  4	2	3	; slot4 = string.match(f, slot6)
		 36	[610]	IST  	   		4	; if string.match
		 37	[610]	JMP  	  5		28	; 	goto 66
		 38	[610]	GGET 	  4		29	; slot4 = _env["string"]
		 39	[610]	TGETS	  4	4	28	; slot4 = string.match
		 40	[610]	MOV  	  5		3	; slot5 = f
		 41	[610]	KSTR 	  6		24	; slot6 = ".astc$"
		 42	[610]	CALL 	  4	2	3	; slot4 = string.match(f, slot6)
		 43	[610]	IST  	   		4	; if string.match
		 44	[610]	JMP  	  5		21	; 	goto 66
		 45	[610]	GGET 	  4		29	; slot4 = _env["string"]
		 46	[610]	TGETS	  4	4	28	; slot4 = string.match
		 47	[610]	MOV  	  5		3	; slot5 = f
		 48	[610]	KSTR 	  6		23	; slot6 = ".dds$"
		 49	[610]	CALL 	  4	2	3	; slot4 = string.match(f, slot6)
		 50	[610]	IST  	   		4	; if string.match
		 51	[610]	JMP  	  5		14	; 	goto 66
		 52	[610]	GGET 	  4		29	; slot4 = _env["string"]
		 53	[610]	TGETS	  4	4	28	; slot4 = string.match
		 54	[610]	MOV  	  5		3	; slot5 = f
		 55	[610]	KSTR 	  6		22	; slot6 = ".pkm.lz4$"
		 56	[610]	CALL 	  4	2	3	; slot4 = string.match(f, slot6)
		 57	[610]	IST  	   		4	; if string.match
		 58	[610]	JMP  	  5		7	; 	goto 66
		 59	[610]	GGET 	  4		29	; slot4 = _env["string"]
		 60	[610]	TGETS	  4	4	28	; slot4 = string.match
		 61	[610]	MOV  	  5		3	; slot5 = f
		 62	[610]	KSTR 	  6		21	; slot6 = ".ktx.lz4$"
		 63	[610]	CALL 	  4	2	3	; slot4 = string.match(f, slot6)
		 64	[610]	ISF  	   		4	; if not string.match
		 65	[610]	JMP  	  5		186	; 	goto 252
		 66	[611]	UGET 	  4		1	; slot4 = uv1"log"
		 67	[611]	TGETS	  4	4	20	; slot4 = uv1"log".paranoid
		 68	[611]	KSTR 	  5		19	; slot5 = "  loading image file %s"
		 69	[611]	MOV  	  6		3	; slot6 = f
		 70	[611]	CALL 	  4	1	3	;  = uv1"log".paranoid(slot5, f)
		 71	[612]	KPRI 	  4		1	; slot4 = false
		 72	[613]	GGET 	  5		29	; slot5 = _env["string"]
		 73	[613]	TGETS	  5	5	28	; slot5 = string.match
		 74	[613]	MOV  	  6		3	; slot6 = f
		 75	[613]	KSTR 	  7		25	; slot7 = ".pkm$"
		 76	[613]	CALL 	  5	2	3	; slot5 = string.match(f, slot7)
		 77	[613]	IST  	   		5	; if string.match
		 78	[613]	JMP  	  6		21	; 	goto 100
		 79	[613]	GGET 	  5		29	; slot5 = _env["string"]
		 80	[613]	TGETS	  5	5	28	; slot5 = string.match
		 81	[613]	MOV  	  6		3	; slot6 = f
		 82	[613]	KSTR 	  7		22	; slot7 = ".pkm.lz4$"
		 83	[613]	CALL 	  5	2	3	; slot5 = string.match(f, slot7)
		 84	[613]	IST  	   		5	; if string.match
		 85	[613]	JMP  	  6		14	; 	goto 100
		 86	[613]	GGET 	  5		29	; slot5 = _env["string"]
		 87	[613]	TGETS	  5	5	28	; slot5 = string.match
		 88	[613]	MOV  	  6		3	; slot6 = f
		 89	[613]	KSTR 	  7		18	; slot7 = ".ktx$"
		 90	[613]	CALL 	  5	2	3	; slot5 = string.match(f, slot7)
		 91	[613]	IST  	   		5	; if string.match
		 92	[613]	JMP  	  6		7	; 	goto 100
		 93	[613]	GGET 	  5		29	; slot5 = _env["string"]
		 94	[613]	TGETS	  5	5	28	; slot5 = string.match
		 95	[613]	MOV  	  6		3	; slot6 = f
		 96	[613]	KSTR 	  7		21	; slot7 = ".ktx.lz4$"
		 97	[613]	CALL 	  5	2	3	; slot5 = string.match(f, slot7)
		 98	[613]	ISF  	   		5	; if not string.match
		 99	[613]	JMP  	  6		16	; 	goto 116
		100	[614]	KPRI 	  4		2	; slot4 = true
		101	[615]	GGET 	  5		17	; slot5 = _env["love"]
		102	[615]	TGETS	  5	5	16	; slot5 = love.graphics
		103	[615]	TGETS	  5	5	15	; slot5 = love.graphics.getCompressedImageFormats
		104	[615]	CALL 	  5	2	1	; slot5 = love.graphics.getCompressedImageFormats()
		105	[616]	TGETS	  6	5	14	; slot6 = supportedformats.ETC1
		106	[616]	IST  	   		6	; if supportedformats.ETC1
		107	[616]	JMP  	  6		53	; 	goto 161
		108	[617]	UGET 	  6		1	; slot6 = uv1"log"
		109	[617]	TGETS	  6	6	31	; slot6 = uv1"log".error
		110	[617]	KSTR 	  7		13	; slot7 = "ETC1 not supported. Could not load %s"
		111	[617]	MOV  	  8		3	; slot8 = f
		112	[617]	CALL 	  6	1	3	;  = uv1"log".error(slot7, f)
		113	[618]	KPRI 	  6		0	; slot6 = nil
		114	[618]	RET1 	  6		2	; return slot6
		115	[619]	JMP  	  5		45	; 	goto 161
		116	[620]	GGET 	  5		29	; slot5 = _env["string"]
		117	[620]	TGETS	  5	5	28	; slot5 = string.match
		118	[620]	MOV  	  6		3	; slot6 = f
		119	[620]	KSTR 	  7		24	; slot7 = ".astc$"
		120	[620]	CALL 	  5	2	3	; slot5 = string.match(f, slot7)
		121	[620]	ISF  	   		5	; if not string.match
		122	[620]	JMP  	  6		16	; 	goto 139
		123	[621]	KPRI 	  4		2	; slot4 = true
		124	[622]	GGET 	  5		17	; slot5 = _env["love"]
		125	[622]	TGETS	  5	5	16	; slot5 = love.graphics
		126	[622]	TGETS	  5	5	15	; slot5 = love.graphics.getCompressedImageFormats
		127	[622]	CALL 	  5	2	1	; slot5 = love.graphics.getCompressedImageFormats()
		128	[623]	TGETS	  6	5	12	; slot6 = supportedformats.ASTC4x4
		129	[623]	IST  	   		6	; if supportedformats.ASTC4x4
		130	[623]	JMP  	  6		30	; 	goto 161
		131	[624]	UGET 	  6		1	; slot6 = uv1"log"
		132	[624]	TGETS	  6	6	31	; slot6 = uv1"log".error
		133	[624]	KSTR 	  7		11	; slot7 = "ASTC not supported. Could not load %s"
		134	[624]	MOV  	  8		3	; slot8 = f
		135	[624]	CALL 	  6	1	3	;  = uv1"log".error(slot7, f)
		136	[625]	KPRI 	  6		0	; slot6 = nil
		137	[625]	RET1 	  6		2	; return slot6
		138	[626]	JMP  	  5		22	; 	goto 161
		139	[627]	GGET 	  5		29	; slot5 = _env["string"]
		140	[627]	TGETS	  5	5	28	; slot5 = string.match
		141	[627]	MOV  	  6		3	; slot6 = f
		142	[627]	KSTR 	  7		23	; slot7 = ".dds$"
		143	[627]	CALL 	  5	2	3	; slot5 = string.match(f, slot7)
		144	[627]	ISF  	   		5	; if not string.match
		145	[627]	JMP  	  6		15	; 	goto 161
		146	[628]	KPRI 	  4		2	; slot4 = true
		147	[629]	GGET 	  5		17	; slot5 = _env["love"]
		148	[629]	TGETS	  5	5	16	; slot5 = love.graphics
		149	[629]	TGETS	  5	5	15	; slot5 = love.graphics.getCompressedImageFormats
		150	[629]	CALL 	  5	2	1	; slot5 = love.graphics.getCompressedImageFormats()
		151	[630]	TGETS	  6	5	10	; slot6 = supportedformats.DXT3
		152	[630]	IST  	   		6	; if supportedformats.DXT3
		153	[630]	JMP  	  6		7	; 	goto 161
		154	[631]	UGET 	  6		1	; slot6 = uv1"log"
		155	[631]	TGETS	  6	6	31	; slot6 = uv1"log".error
		156	[631]	KSTR 	  7		9	; slot7 = "DXT3 not supported. Could not load %s"
		157	[631]	MOV  	  8		3	; slot8 = f
		158	[631]	CALL 	  6	1	3	;  = uv1"log".error(slot7, f)
		159	[632]	KPRI 	  6		0	; slot6 = nil
		160	[632]	RET1 	  6		2	; return slot6
		161	[636]	KPRI 	  5		0	; slot5 = nil
		162	[637]	ISF  	   		4	; if not compressed
		163	[637]	JMP  	  6		19	; 	goto 183
		164	[638]	GGET 	  6		17	; slot6 = _env["love"]
		165	[638]	TGETS	  6	6	8	; slot6 = love.image
		166	[638]	TGETS	  6	6	7	; slot6 = love.image.newCompressedData
		167	[638]	MOV  	  7		3	; slot7 = f
		168	[638]	CALL 	  6	2	2	; slot6 = love.image.newCompressedData(f)
		169	[639]	IST  	   		6	; if imd
		170	[639]	JMP  	  7		6	; 	goto 177
		171	[640]	UGET 	  7		1	; slot7 = uv1"log"
		172	[640]	TGETS	  7	7	31	; slot7 = uv1"log".error
		173	[640]	KSTR 	  8		6	; slot8 = "Compressed image %s could not be loaded"
		174	[640]	MOV  	  9		3	; slot9 = f
		175	[640]	CALL 	  7	1	3	;  = uv1"log".error(slot8, f)
		176	[641]	RET0 	  0		1	; return
		177	[643]	UGET 	  7		2	; slot7 = uv2"G"
		178	[643]	TGETS	  7	7	5	; slot7 = uv2"G".newImage
		179	[643]	MOV  	  8		6	; slot8 = imd
		180	[643]	CALL 	  7	2	2	; slot7 = uv2"G".newImage(imd)
		181	[643]	MOV  	  5		7	; slot5 = uv2"G".newImage
		182	[643]	JMP  	  6		5	; 	goto 188
		183	[645]	UGET 	  6		2	; slot6 = uv2"G"
		184	[645]	TGETS	  6	6	5	; slot6 = uv2"G".newImage
		185	[645]	MOV  	  7		3	; slot7 = f
		186	[645]	CALL 	  6	2	2	; slot6 = uv2"G".newImage(f)
		187	[645]	MOV  	  5		6	; slot5 = uv2"G".newImage
		188	[648]	IST  	   		5	; if im
		189	[648]	JMP  	  6		6	; 	goto 196
		190	[649]	UGET 	  6		1	; slot6 = uv1"log"
		191	[649]	TGETS	  6	6	31	; slot6 = uv1"log".error
		192	[649]	KSTR 	  7		4	; slot7 = "Image %s could not be created"
		193	[649]	MOV  	  8		3	; slot8 = f
		194	[649]	CALL 	  6	1	3	;  = uv1"log".error(slot7, f)
		195	[649]	JMP  	  6		56	; 	goto 252
		196	[651]	MOV  	  7		5	; slot7 = im
		197	[651]	TGETS	  6	5	3	; slot6 = im.getDimensions
		198	[651]	CALL 	  6	3	2	; slot6, slot7 = im.getDimensions(im)
		199	[652]	GGET 	  8		29	; slot8 = _env["string"]
		200	[652]	TGETS	  8	8	2	; slot8 = string.gsub
		201	[652]	MOV  	  9		1	; slot9 = fn
		202	[652]	KSTR 	 10		27	; slot10 = ".png$"
		203	[652]	KSTR 	 11		1	; slot11 = ""
		204	[652]	CALL 	  8	2	4	; slot8 = string.gsub(fn, slot10, slot11)
		205	[653]	GGET 	  9		29	; slot9 = _env["string"]
		206	[653]	TGETS	  9	9	2	; slot9 = string.gsub
		207	[653]	MOV  	 10		8	; slot10 = key
		208	[653]	KSTR 	 11		0	; slot11 = ".lz4$"
		209	[653]	KSTR 	 12		1	; slot12 = ""
		210	[653]	CALL 	  9	2	4	; slot9 = string.gsub(key, slot11, slot12)
		211	[653]	MOV  	  8		9	; slot8 = string.gsub
		212	[654]	GGET 	  9		29	; slot9 = _env["string"]
		213	[654]	TGETS	  9	9	2	; slot9 = string.gsub
		214	[654]	MOV  	 10		8	; slot10 = key
		215	[654]	KSTR 	 11		26	; slot11 = ".jpg$"
		216	[654]	KSTR 	 12		1	; slot12 = ""
		217	[654]	CALL 	  9	2	4	; slot9 = string.gsub(key, slot11, slot12)
		218	[654]	MOV  	  8		9	; slot8 = string.gsub
		219	[655]	GGET 	  9		29	; slot9 = _env["string"]
		220	[655]	TGETS	  9	9	2	; slot9 = string.gsub
		221	[655]	MOV  	 10		8	; slot10 = key
		222	[655]	KSTR 	 11		25	; slot11 = ".pkm$"
		223	[655]	KSTR 	 12		1	; slot12 = ""
		224	[655]	CALL 	  9	2	4	; slot9 = string.gsub(key, slot11, slot12)
		225	[655]	MOV  	  8		9	; slot8 = string.gsub
		226	[656]	GGET 	  9		29	; slot9 = _env["string"]
		227	[656]	TGETS	  9	9	2	; slot9 = string.gsub
		228	[656]	MOV  	 10		8	; slot10 = key
		229	[656]	KSTR 	 11		18	; slot11 = ".ktx$"
		230	[656]	KSTR 	 12		1	; slot12 = ""
		231	[656]	CALL 	  9	2	4	; slot9 = string.gsub(key, slot11, slot12)
		232	[656]	MOV  	  8		9	; slot8 = string.gsub
		233	[657]	GGET 	  9		29	; slot9 = _env["string"]
		234	[657]	TGETS	  9	9	2	; slot9 = string.gsub
		235	[657]	MOV  	 10		8	; slot10 = key
		236	[657]	KSTR 	 11		24	; slot11 = ".astc$"
		237	[657]	KSTR 	 12		1	; slot12 = ""
		238	[657]	CALL 	  9	2	4	; slot9 = string.gsub(key, slot11, slot12)
		239	[657]	MOV  	  8		9	; slot8 = string.gsub
		240	[658]	GGET 	  9		29	; slot9 = _env["string"]
		241	[658]	TGETS	  9	9	2	; slot9 = string.gsub
		242	[658]	MOV  	 10		8	; slot10 = key
		243	[658]	KSTR 	 11		23	; slot11 = ".dds$"
		244	[658]	KSTR 	 12		1	; slot12 = ""
		245	[658]	CALL 	  9	2	4	; slot9 = string.gsub(key, slot11, slot12)
		246	[658]	MOV  	  8		9	; slot8 = string.gsub
		247	[659]	MOV  	  9		8	; slot9 = key
		248	[659]	MOV  	 10		5	; slot10 = im
		249	[659]	MOV  	 11		6	; slot11 = w
		250	[659]	MOV  	 12		7	; slot12 = h
		251	[659]	RET  	  9		5	; return key, im, w, h
		252	[662]	RET0 	  0		1	; return
	 91	[604]	TSETS	  8	4	13	; image_db.load_image_file = slot8
	 92	[696]	FNEW 	  8		10	; @./lib/klove/image_db.lua:664-696: 5 args, 1 upvalues, 16 slots
		
		;;;; constant tables ;;;;
		ktable#10 = [
			#1: 0,
			#2: 0,
			#3: 0,
			#4: 0,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	G
		;;;; variable info ;;;;
		  0-63:	self
		  0-63:	name
		  0-63:	image
		  0-63:	group
		  0-63:	scale
		  9-63:	name_scale
		  12-63:	w
		  12-63:	h
		;;;; instructions ;;;;
		  1	[674]	IST  	   		4	; if scale
		  2	[674]	JMP  	  5		1	; 	goto 4
		  3	[674]	KSHORT	  4		1	; slot4 = 1
		  4	[675]	GGET 	  5		17	; slot5 = _env["string"]
		  5	[675]	TGETS	  5	5	16	; slot5 = string.format
		  6	[675]	KSTR 	  6		15	; slot6 = "%s-%.6f"
		  7	[675]	MOV  	  7		3	; slot7 = group
		  8	[675]	MOV  	  8		4	; slot8 = scale
		  9	[675]	CALL 	  5	2	4	; slot5 = string.format(slot6, group, scale)
		 10	[676]	MOV  	  7		2	; slot7 = image
		 11	[676]	TGETS	  6	2	14	; slot6 = image.getDimensions
		 12	[676]	CALL 	  6	3	2	; slot6, slot7 = image.getDimensions(image)
		 13	[678]	TNEW 	  8		0	; slot8 = new table( array: 0, dict: 1)
		 14	[678]	GSET 	  8		13	; _env["v"] = slot8
		 15	[679]	GGET 	  8		13	; slot8 = _env["v"]
		 16	[679]	TNEW 	  9		3	; slot9 = new table( array: 3, dict: 1)
		 17	[679]	TSETB	  6	9	1	; slot9[1] = w
		 18	[679]	TSETB	  7	9	2	; slot9[2] = h
		 19	[679]	TSETS	  9	8	12	; v.size = slot9
		 20	[680]	GGET 	  8		13	; slot8 = _env["v"]
		 21	[680]	TDUP 	  9		10	; slot9 = copy table#k10
		 22	[680]	TSETS	  9	8	11	; v.trim = slot9
		 23	[681]	GGET 	  8		13	; slot8 = _env["v"]
		 24	[681]	TSETS	  1	8	9	; v.a_name = name
		 25	[682]	GGET 	  8		13	; slot8 = _env["v"]
		 26	[682]	TNEW 	  9		3	; slot9 = new table( array: 3, dict: 1)
		 27	[682]	TSETB	  6	9	1	; slot9[1] = w
		 28	[682]	TSETB	  7	9	2	; slot9[2] = h
		 29	[682]	TSETS	  9	8	8	; v.a_size = slot9
		 30	[683]	GGET 	  8		13	; slot8 = _env["v"]
		 31	[683]	TSETS	  5	8	7	; v.group = name_scale
		 32	[684]	GGET 	  8		13	; slot8 = _env["v"]
		 33	[684]	UGET 	  9		0	; slot9 = uv0"G"
		 34	[684]	TGETS	  9	9	5	; slot9 = uv0"G".newQuad
		 35	[684]	KSHORT	 10		0	; slot10 = 0
		 36	[684]	KSHORT	 11		0	; slot11 = 0
		 37	[684]	MOV  	 12		6	; slot12 = w
		 38	[684]	MOV  	 13		7	; slot13 = h
		 39	[684]	MOV  	 14		6	; slot14 = w
		 40	[684]	MOV  	 15		7	; slot15 = h
		 41	[684]	CALL 	  9	2	7	; slot9 = uv0"G".newQuad(slot10, slot11, w, h, w, h)
		 42	[684]	TSETS	  9	8	6	; v.quad = uv0"G".newQuad
		 43	[685]	GGET 	  8		13	; slot8 = _env["v"]
		 44	[685]	TSETS	  1	8	4	; v.atlas = name
		 45	[686]	GGET 	  8		13	; slot8 = _env["v"]
		 46	[686]	TSETS	  4	8	3	; v.ref_scale = scale
		 47	[687]	TGETS	  8	0	2	; slot8 = self.db_atlas
		 48	[687]	GGET 	  9		13	; slot9 = _env["v"]
		 49	[687]	TSETV	  9	8	1	; self.db_atlas[name] = v
		 50	[690]	TGETS	  8	0	1	; slot8 = self.db_images
		 51	[690]	TNEW 	  9		4	; slot9 = new table( array: 4, dict: 1)
		 52	[690]	TSETB	  2	9	1	; slot9[1] = image
		 53	[690]	TSETB	  6	9	2	; slot9[2] = w
		 54	[690]	TSETB	  7	9	3	; slot9[3] = h
		 55	[690]	TSETV	  9	8	1	; self.db_images[name] = slot9
		 56	[693]	TGETS	  8	0	0	; slot8 = self.atlas_uses
		 57	[693]	TGETV	  8	8	5	; slot8 = self.atlas_uses[name_scale]
		 58	[693]	IST  	   		8	; if slot8
		 59	[693]	JMP  	  8		3	; 	goto 63
		 60	[694]	TGETS	  8	0	0	; slot8 = self.atlas_uses
		 61	[694]	KSHORT	  9		1	; slot9 = 1
		 62	[694]	TSETV	  9	8	5	; self.atlas_uses[name_scale] = slot9
		 63	[696]	RET0 	  0		1	; return
	 93	[664]	TSETS	  8	4	11	; image_db.add_image = slot8
	 94	[701]	FNEW 	  8		8	; @./lib/klove/image_db.lua:698-701: 2 args, 0 upvalues, 4 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-7:	self
		  0-7:	name
		;;;; instructions ;;;;
		  1	[699]	TGETS	  2	0	1	; slot2 = self.db_images
		  2	[699]	KPRI 	  3		0	; slot3 = nil
		  3	[699]	TSETV	  3	2	1	; self.db_images[name] = slot3
		  4	[700]	TGETS	  2	0	0	; slot2 = self.db_atlas
		  5	[700]	KPRI 	  3		0	; slot3 = nil
		  6	[700]	TSETV	  3	2	1	; self.db_atlas[name] = slot3
		  7	[701]	RET0 	  0		1	; return
	 95	[698]	TSETS	  8	4	9	; image_db.remove_image = slot8
	 96	[712]	FNEW 	  8		6	; @./lib/klove/image_db.lua:703-712: 1 args, 2 upvalues, 15 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	DEFAULT_ATLAS_1X1_SPRITES
		  1:	G
		;;;; variable info ;;;;
		  0-39:	self
		  7-36:	<generator>
		  7-36:	<state>
		  7-36:	<control>
		  8-34:	name
		  8-34:	color
		  14-34:	id
		  27-34:	im
		;;;; instructions ;;;;
		  1	[704]	TGETS	  1	0	8	; slot1 = self._default_atlas_loaded
		  2	[704]	ISF  	   		1	; if not self._default_atlas_loaded
		  3	[704]	JMP  	  2		1	; 	goto 5
		  4	[704]	RET0 	  0		1	; return
		  5	[705]	GGET 	  1		7	; slot1 = _env["pairs"]
		  6	[705]	UGET 	  2		0	; slot2 = uv0"DEFAULT_ATLAS_1X1_SPRITES"
		  7	[705]	CALL 	  1	4	2	; slot1, slot2, slot3 = pairs(uv0"DEFAULT_ATLAS_1X1_SPRITES")
		  8	[705]	ISNEXT	  4		26	; Verify ITERN at 35; goto 35
		  9	[706]	GGET 	  6		6	; slot6 = _env["love"]
		 10	[706]	TGETS	  6	6	5	; slot6 = love.image
		 11	[706]	TGETS	  6	6	4	; slot6 = love.image.newImageData
		 12	[706]	KSHORT	  7		1	; slot7 = 1
		 13	[706]	KSHORT	  8		1	; slot8 = 1
		 14	[706]	CALL 	  6	2	3	; slot6 = love.image.newImageData(slot7, slot8)
		 15	[707]	MOV  	  8		6	; slot8 = id
		 16	[707]	TGETS	  7	6	3	; slot7 = id.setPixel
		 17	[707]	KSHORT	  9		0	; slot9 = 0
		 18	[707]	KSHORT	 10		0	; slot10 = 0
		 19	[707]	TGETB	 11	5	1	; slot11 = color[1]
		 20	[707]	TGETB	 12	5	2	; slot12 = color[2]
		 21	[707]	TGETB	 13	5	3	; slot13 = color[3]
		 22	[707]	TGETB	 14	5	4	; slot14 = color[4]
		 23	[707]	CALL 	  7	1	8	;  = id.setPixel(id, slot9, slot10, slot11, slot12, slot13, slot14)
		 24	[708]	UGET 	  7		1	; slot7 = uv1"G"
		 25	[708]	TGETS	  7	7	2	; slot7 = uv1"G".newImage
		 26	[708]	MOV  	  8		6	; slot8 = id
		 27	[708]	CALL 	  7	2	2	; slot7 = uv1"G".newImage(id)
		 28	[709]	MOV  	  9		0	; slot9 = self
		 29	[709]	TGETS	  8	0	1	; slot8 = self.add_image
		 30	[709]	MOV  	 10		4	; slot10 = name
		 31	[709]	MOV  	 11		7	; slot11 = im
		 32	[709]	GGET 	 12		0	; slot12 = _env["IMAGE_DB_DEFAULT_ATLAS_GROUP"]
		 33	[709]	KSHORT	 13		1	; slot13 = 1
		 34	[709]	CALL 	  8	1	6	;  = self.add_image(self, name, im, IMAGE_DB_DEFAULT_ATLAS_GROUP, slot13)
		 35	[705]	ITERN	  4	3	3	; slot4, slot5, slot6 = slot1<generator>, slot2<state>, slot3<control>; slot4, slot5 = slot1<generator>(slot2<state>, slot3<control>)
		 36	[705]	ITERL	  4		-28	; slot3<control> = slot4; if slot4 != nil goto 9
		 37	[711]	KPRI 	  1		2	; slot1 = true
		 38	[711]	TSETS	  1	0	8	; self._default_atlas_loaded = slot1
		 39	[712]	RET0 	  0		1	; return
	 97	[703]	TSETS	  8	4	7	; image_db.load_default_atlas = slot8
	 98	[723]	FNEW 	  8		4	; @./lib/klove/image_db.lua:714-723: 1 args, 1 upvalues, 8 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	DEFAULT_ATLAS_1X1_SPRITES
		;;;; variable info ;;;;
		  0-29:	self
		  7-14:	<generator>
		  7-14:	<state>
		  7-14:	<control>
		  8-12:	name
		  20-29:	name_scale
		;;;; instructions ;;;;
		  1	[715]	TGETS	  1	0	8	; slot1 = self._default_atlas_loaded
		  2	[715]	IST  	   		1	; if self._default_atlas_loaded
		  3	[715]	JMP  	  1		1	; 	goto 5
		  4	[715]	RET0 	  0		1	; return
		  5	[716]	GGET 	  1		7	; slot1 = _env["pairs"]
		  6	[716]	UGET 	  2		0	; slot2 = uv0"DEFAULT_ATLAS_1X1_SPRITES"
		  7	[716]	CALL 	  1	4	2	; slot1, slot2, slot3 = pairs(uv0"DEFAULT_ATLAS_1X1_SPRITES")
		  8	[716]	ISNEXT	  4		4	; Verify ITERN at 13; goto 13
		  9	[717]	MOV  	  6		0	; slot6 = self
		 10	[717]	TGETS	  5	0	6	; slot5 = self.remove_image
		 11	[717]	MOV  	  7		4	; slot7 = name
		 12	[717]	CALL 	  5	1	3	;  = self.remove_image(self, name)
		 13	[716]	ITERN	  4	2	3	; slot4, slot5, slot6 = slot1<generator>, slot2<state>, slot3<control>; slot4 = slot1<generator>(slot2<state>, slot3<control>)
		 14	[716]	ITERL	  4		-6	; slot3<control> = slot4; if slot4 != nil goto 9
		 15	[719]	GGET 	  1		5	; slot1 = _env["string"]
		 16	[719]	TGETS	  1	1	4	; slot1 = string.format
		 17	[719]	KSTR 	  2		3	; slot2 = "%s-%.6f"
		 18	[719]	GGET 	  3		2	; slot3 = _env["IMAGE_DB_DEFAULT_ATLAS_GROUP"]
		 19	[719]	KSHORT	  4		1	; slot4 = 1
		 20	[719]	CALL 	  1	2	4	; slot1 = string.format(slot2, IMAGE_DB_DEFAULT_ATLAS_GROUP, slot4)
		 21	[720]	TGETS	  2	0	1	; slot2 = self.atlas_uses
		 22	[720]	KPRI 	  3		0	; slot3 = nil
		 23	[720]	TSETV	  3	2	1	; self.atlas_uses[name_scale] = slot3
		 24	[721]	MOV  	  3		0	; slot3 = self
		 25	[721]	TGETS	  2	0	0	; slot2 = self.purge_atlas
		 26	[721]	CALL 	  2	1	2	;  = self.purge_atlas(self)
		 27	[722]	KPRI 	  2		1	; slot2 = false
		 28	[722]	TSETS	  2	0	8	; self._default_atlas_loaded = slot2
		 29	[723]	RET0 	  0		1	; return
	 99	[714]	TSETS	  8	4	5	; image_db.unload_default_atlas = slot8
	100	[750]	FNEW 	  8		2	; @./lib/klove/image_db.lua:727-750: 3 args, 1 upvalues, 11 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-67:	self
		  0-67:	name
		  0-67:	optional
		  2-67:	i
		  20-30:	key
		  20-30:	im
		  20-30:	w
		  20-30:	h
		;;;; instructions ;;;;
		  1	[730]	TGETS	  3	0	6	; slot3 = self.db_images
		  2	[730]	TGETV	  3	3	1	; slot3 = self.db_images[name]
		  3	[731]	TGETS	  4	0	6	; slot4 = self.db_images
		  4	[731]	TGETV	  4	4	1	; slot4 = self.db_images[name]
		  5	[731]	ISF  	   		4	; if not slot4
		  6	[731]	JMP  	  5		30	; 	goto 37
		  7	[732]	TGETB	  4	3	1	; slot4 = i[1]
		  8	[732]	ISNEP	  4		0	; if slot4 ~= nil
		  9	[732]	JMP  	  4		22	; 	goto 32
		 10	[732]	TGETB	  4	3	4	; slot4 = i[4]
		 11	[732]	ISF  	   		4	; if not slot4
		 12	[732]	JMP  	  5		19	; 	goto 32
		 13	[732]	TGETB	  4	3	5	; slot4 = i[5]
		 14	[732]	ISF  	   		4	; if not slot4
		 15	[732]	JMP  	  5		16	; 	goto 32
		 16	[734]	MOV  	  5		0	; slot5 = self
		 17	[734]	TGETS	  4	0	5	; slot4 = self.load_image_file
		 18	[734]	TGETB	  6	3	4	; slot6 = i[4]
		 19	[734]	TGETB	  7	3	5	; slot7 = i[5]
		 20	[734]	CALL 	  4	5	4	; slot4, slot5, slot6, slot7 = self.load_image_file(self, slot6, slot7)
		 21	[735]	TGETS	  8	0	6	; slot8 = self.db_images
		 22	[735]	TNEW 	  9		4	; slot9 = new table( array: 4, dict: 1)
		 23	[735]	TSETB	  5	9	1	; slot9[1] = im
		 24	[735]	TSETB	  6	9	2	; slot9[2] = w
		 25	[735]	TSETB	  7	9	3	; slot9[3] = h
		 26	[735]	TSETV	  9	8	1	; self.db_images[name] = slot9
		 27	[736]	MOV  	  8		5	; slot8 = im
		 28	[736]	MOV  	  9		6	; slot9 = w
		 29	[736]	MOV  	 10		7	; slot10 = h
		 30	[736]	RET  	  8		4	; return im, w, h
		 31	[736]	JMP  	  4		35	; 	goto 67
		 32	[738]	TGETB	  4	3	1	; slot4 = i[1]
		 33	[738]	TGETB	  5	3	2	; slot5 = i[2]
		 34	[738]	TGETB	  6	3	3	; slot6 = i[3]
		 35	[738]	RET  	  4		4	; return slot4, slot5, slot6
		 36	[739]	JMP  	  4		30	; 	goto 67
		 37	[741]	IST  	   		1	; if name
		 38	[741]	JMP  	  4		4	; 	goto 43
		 39	[741]	TGETS	  4	0	4	; slot4 = self.missing_images
		 40	[741]	TGETS	  4	4	3	; slot4 = self.missing_images.nil
		 41	[741]	IST  	   		4	; if self.missing_images.nil
		 42	[741]	JMP  	  5		4	; 	goto 47
		 43	[741]	TGETS	  4	0	4	; slot4 = self.missing_images
		 44	[741]	TGETV	  4	4	1	; slot4 = self.missing_images[name]
		 45	[741]	ISF  	   		4	; if not slot4
		 46	[741]	JMP  	  5		2	; 	goto 49
		 47	[742]	KPRI 	  4		0	; slot4 = nil
		 48	[742]	RET1 	  4		2	; return slot4
		 49	[744]	IST  	   		2	; if optional
		 50	[744]	JMP  	  4		8	; 	goto 59
		 51	[745]	UGET 	  4		0	; slot4 = uv0"log"
		 52	[745]	TGETS	  4	4	2	; slot4 = uv0"log".error
		 53	[745]	KSTR 	  5		1	; slot5 = "Image %s not found in the images db
		%s"
		 54	[745]	MOV  	  6		1	; slot6 = name
		 55	[745]	MOV  	  8		0	; slot8 = self
		 56	[745]	TGETS	  7	0	0	; slot7 = self.get_short_stats
		 57	[745]	CALL 	  7	0	2	; MULTRES = self.get_short_stats(self)
		 58	[745]	CALLM	  4	1	2	;  = uv0"log".error(slot5, name, ...MULTRES)
		 59	[747]	TGETS	  4	0	4	; slot4 = self.missing_images
		 60	[747]	ISTC 	  5		1	; slot5 = name; if name
		 61	[747]	JMP  	  5		1	; 	goto 63
		 62	[747]	KSTR 	  5		3	; slot5 = "nil"
		 63	[747]	KPRI 	  6		2	; slot6 = true
		 64	[747]	TSETV	  6	4	5	; self.missing_images[slot5] = slot6
		 65	[748]	KPRI 	  4		0	; slot4 = nil
		 66	[748]	RET1 	  4		2	; return slot4
		 67	[750]	RET0 	  0		1	; return
	101	[727]	TSETS	  8	4	3	; image_db.i = slot8
	102	[771]	FNEW 	  8		0	; @./lib/klove/image_db.lua:752-771: 3 args, 1 upvalues, 9 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-47:	self
		  0-47:	name
		  0-47:	optional
		  2-47:	s
		;;;; instructions ;;;;
		  1	[754]	TGETS	  3	0	8	; slot3 = self.db_atlas
		  2	[754]	TGETV	  3	3	1	; slot3 = self.db_atlas[name]
		  3	[755]	GGET 	  4		7	; slot4 = _env["DBG_REPLACE_MISSING_TEXTURES"]
		  4	[755]	ISF  	   		4	; if not DBG_REPLACE_MISSING_TEXTURES
		  5	[755]	JMP  	  5		9	; 	goto 15
		  6	[755]	IST  	   		3	; if s
		  7	[755]	JMP  	  4		7	; 	goto 15
		  8	[757]	TGETS	  4	0	8	; slot4 = self.db_atlas
		  9	[757]	TGETS	  3	4	6	; slot3 = self.db_atlas._debug_textures_missing
		 10	[758]	UGET 	  4		0	; slot4 = uv0"log"
		 11	[758]	TGETS	  4	4	5	; slot4 = uv0"log".error
		 12	[758]	KSTR 	  5		4	; slot5 = "DBG_REPLACE_MISSING_TEXTURES: replaced %s"
		 13	[758]	MOV  	  6		1	; slot6 = name
		 14	[758]	CALL 	  4	1	3	;  = uv0"log".error(slot5, name)
		 15	[760]	IST  	   		3	; if s
		 16	[760]	JMP  	  4		30	; 	goto 47
		 17	[761]	IST  	   		1	; if name
		 18	[761]	JMP  	  4		4	; 	goto 23
		 19	[761]	TGETS	  4	0	3	; slot4 = self.missing_sprites
		 20	[761]	TGETS	  4	4	2	; slot4 = self.missing_sprites.nil
		 21	[761]	IST  	   		4	; if self.missing_sprites.nil
		 22	[761]	JMP  	  5		4	; 	goto 27
		 23	[761]	TGETS	  4	0	3	; slot4 = self.missing_sprites
		 24	[761]	TGETV	  4	4	1	; slot4 = self.missing_sprites[name]
		 25	[761]	ISF  	   		4	; if not slot4
		 26	[761]	JMP  	  5		2	; 	goto 29
		 27	[762]	KPRI 	  4		0	; slot4 = nil
		 28	[762]	RET1 	  4		2	; return slot4
		 29	[764]	IST  	   		2	; if optional
		 30	[764]	JMP  	  4		8	; 	goto 39
		 31	[765]	UGET 	  4		0	; slot4 = uv0"log"
		 32	[765]	TGETS	  4	4	5	; slot4 = uv0"log".error
		 33	[765]	KSTR 	  5		1	; slot5 = "Sprite %s was not found in the atlas db.
		%s"
		 34	[765]	MOV  	  6		1	; slot6 = name
		 35	[765]	MOV  	  8		0	; slot8 = self
		 36	[765]	TGETS	  7	0	0	; slot7 = self.get_short_stats
		 37	[765]	CALL 	  7	0	2	; MULTRES = self.get_short_stats(self)
		 38	[765]	CALLM	  4	1	2	;  = uv0"log".error(slot5, name, ...MULTRES)
		 39	[767]	TGETS	  4	0	3	; slot4 = self.missing_sprites
		 40	[767]	ISTC 	  5		1	; slot5 = name; if name
		 41	[767]	JMP  	  5		1	; 	goto 43
		 42	[767]	KSTR 	  5		2	; slot5 = "nil"
		 43	[767]	KPRI 	  6		2	; slot6 = true
		 44	[767]	TSETV	  6	4	5	; self.missing_sprites[slot5] = slot6
		 45	[768]	KPRI 	  4		0	; slot4 = nil
		 46	[768]	RET1 	  4		2	; return slot4
		 47	[770]	RET1 	  3		2	; return s
	103	[752]	TSETS	  8	4	1	; image_db.s = slot8
	104	[773]	UCLO 	  0		0	; nil uvs >= r0; goto 105
	105	[773]	RET1 	  4		2	; return image_db
	
