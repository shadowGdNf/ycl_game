;
; Disassemble of /var/folders/jr/tn4pzbcj2gj37f5cg3w5qbzm0000gn/T/rea-extracted-f265f614-2b91-4e81-a212-02037bc4e4ba/assets/gc32/all/wave_db.lua
;
; Source file: @./all/wave_db.lua
;
; Flags:
;	Stripped: No
;	Endianness: Little
;	FFI: Not present
;

main @./all/wave_db.lua:0-1223: 0+ args, 0 upvalues, 17 slots
	;;;; constant tables ;;;;
	ktable#68 = [
		]
	
	
	ktable#70 = [
		]
	
	
	ktable#72 = [
		]
	
	
	ktable#74 = [
		]
	
	
	ktable#76 = [
		]
	
	
	ktable#78 = [
		]
	
	
	ktable#80 = [
		]
	
	
	ktable#82 = [
		]
	
	
	ktable#84 = [
		]
	
	
	ktable#86 = [
		]
	
	
	ktable#88 = [
		]
	
	
	ktable#90 = [
		]
	
	
	ktable#92 = [
		]
	
	
	ktable#95 = [
		]
	
	
	ktable#97 = [
		]
	
	
	ktable#99 = [
		]
	
	
	ktable#102 = [
		]
	
	
	ktable#106 = [
		]
	
	
	;;;; upvalue names ;;;;
	;;;; variable info ;;;;
	  7-242:	log
	  10-242:	km
	  12-242:	FS
	  15-242:	E
	  18-242:	tsv
	  25-242:	wave_db
	  34-242:	WS_IDLE
	  35-242:	WS_PENDING
	  36-242:	WS_RUNNING
	  37-242:	WS_DONE
	  38-242:	WS_REMOVED
	  70-242:	tsv_cmd_col
	  71-242:	tsv_value_col
	  72-242:	log_e
	;;;; instructions ;;;;
	  1	[  5]	GGET 	  0		172	; slot0 = _env["require"]
	  2	[  5]	KSTR 	  1		171	; slot1 = "klua.log"
	  3	[  5]	CALL 	  0	2	2	; slot0 = require(slot1)
	  4	[  5]	MOV  	  1		0	; slot1 = slot0
	  5	[  5]	TGETS	  0	0	170	; slot0 = slot0.new
	  6	[  5]	KSTR 	  2		169	; slot2 = "wave_db"
	  7	[  5]	CALL 	  0	2	3	; slot0 = <unknown table>.new(slot1, slot2)
	  8	[  7]	GGET 	  1		172	; slot1 = _env["require"]
	  9	[  7]	KSTR 	  2		168	; slot2 = "klua.macros"
	 10	[  7]	CALL 	  1	2	2	; slot1 = require(slot2)
	 11	[  8]	GGET 	  2		167	; slot2 = _env["love"]
	 12	[  8]	TGETS	  2	2	166	; slot2 = love.filesystem
	 13	[  9]	GGET 	  3		172	; slot3 = _env["require"]
	 14	[  9]	KSTR 	  4		165	; slot4 = "entity_db"
	 15	[  9]	CALL 	  3	2	2	; slot3 = require(slot4)
	 16	[ 10]	GGET 	  4		172	; slot4 = _env["require"]
	 17	[ 10]	KSTR 	  5		164	; slot5 = "klua.tsv"
	 18	[ 10]	CALL 	  4	2	2	; slot4 = require(slot5)
	 19	[ 11]	GGET 	  5		172	; slot5 = _env["require"]
	 20	[ 11]	KSTR 	  6		163	; slot6 = "constants"
	 21	[ 11]	CALL 	  5	1	2	;  = require(slot6)
	 22	[ 12]	GGET 	  5		172	; slot5 = _env["require"]
	 23	[ 12]	KSTR 	  6		162	; slot6 = "klua.string"
	 24	[ 12]	CALL 	  5	1	2	;  = require(slot6)
	 25	[ 16]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
	 26	[ 17]	KPRI 	  6		0	; slot6 = nil
	 27	[ 17]	TSETS	  6	5	161	; wave_db.format = slot6
	 28	[ 18]	KPRI 	  6		0	; slot6 = nil
	 29	[ 18]	TSETS	  6	5	160	; wave_db.db = slot6
	 30	[ 19]	KPRI 	  6		0	; slot6 = nil
	 31	[ 19]	TSETS	  6	5	159	; wave_db.game_mode = slot6
	 32	[ 21]	KPRI 	  6		0	; slot6 = nil
	 33	[ 21]	TSETS	  6	5	158	; wave_db.parse_errors = slot6
	 34	[ 24]	KSTR 	  6		157	; slot6 = "idle"
	 35	[ 25]	KSTR 	  7		156	; slot7 = "pending"
	 36	[ 26]	KSTR 	  8		155	; slot8 = "running"
	 37	[ 27]	KSTR 	  9		154	; slot9 = "done"
	 38	[ 28]	KSTR 	 10		153	; slot10 = "removed"
	 39	[ 30]	TSETS	  6	5	152	; wave_db.WS_IDLE = WS_IDLE
	 40	[ 31]	TSETS	  7	5	151	; wave_db.WS_PENDING = WS_PENDING
	 41	[ 32]	TSETS	  8	5	150	; wave_db.WS_RUNNING = WS_RUNNING
	 42	[ 33]	TSETS	  9	5	149	; wave_db.WS_DONE = WS_DONE
	 43	[ 34]	TSETS	 10	5	148	; wave_db.WS_REMOVED = WS_REMOVED
	 44	[ 37]	TNEW 	 11		6144	; slot11 = new table( array: 0, dict: 8)
	 45	[ 38]	GGET 	 12		146	; slot12 = _env["GAME_MODE_CAMPAIGN"]
	 46	[ 38]	KSTR 	 13		145	; slot13 = "campaign"
	 47	[ 38]	TSETV	 13	11	12	; slot11[GAME_MODE_CAMPAIGN] = slot13
	 48	[ 39]	GGET 	 12		144	; slot12 = _env["GAME_MODE_HEROIC"]
	 49	[ 39]	KSTR 	 13		143	; slot13 = "heroic"
	 50	[ 39]	TSETV	 13	11	12	; slot11[GAME_MODE_HEROIC] = slot13
	 51	[ 40]	GGET 	 12		142	; slot12 = _env["GAME_MODE_IRON"]
	 52	[ 40]	KSTR 	 13		141	; slot13 = "iron"
	 53	[ 40]	TSETV	 13	11	12	; slot11[GAME_MODE_IRON] = slot13
	 54	[ 41]	GGET 	 12		140	; slot12 = _env["GAME_MODE_ENDLESS"]
	 55	[ 41]	KSTR 	 13		139	; slot13 = "endless"
	 56	[ 41]	TSETV	 13	11	12	; slot11[GAME_MODE_ENDLESS] = slot13
	 57	[ 42]	GGET 	 12		138	; slot12 = _env["GAME_MODE_NO_HEROES"]
	 58	[ 42]	KSTR 	 13		137	; slot13 = "no_hero"
	 59	[ 42]	TSETV	 13	11	12	; slot11[GAME_MODE_NO_HEROES] = slot13
	 60	[ 43]	GGET 	 12		136	; slot12 = _env["GAME_MODE_EXTRA_HEROES"]
	 61	[ 43]	KSTR 	 13		135	; slot13 = "extra_heroes"
	 62	[ 43]	TSETV	 13	11	12	; slot11[GAME_MODE_EXTRA_HEROES] = slot13
	 63	[ 44]	GGET 	 12		134	; slot12 = _env["GAME_MODE_BLITZ"]
	 64	[ 44]	KSTR 	 13		133	; slot13 = "blitz"
	 65	[ 44]	TSETV	 13	11	12	; slot11[GAME_MODE_BLITZ] = slot13
	 66	[ 45]	GGET 	 12		132	; slot12 = _env["GAME_MODE_KR1"]
	 67	[ 45]	KSTR 	 13		131	; slot13 = "kr1"
	 68	[ 45]	TSETV	 13	11	12	; slot11[GAME_MODE_KR1] = slot13
	 69	[ 46]	TSETS	 11	5	147	; wave_db.gms = slot11
	 70	[ 48]	KSHORT	 11		2	; slot11 = 2
	 71	[ 49]	KSHORT	 12		3	; slot12 = 3
	 72	[ 58]	FNEW 	 13		130	; @./all/wave_db.lua:52-58: 1+ args, 2 upvalues, 6 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	wave_db
		  1:	log
		;;;; variable info ;;;;
		  0-25:	fmt
		;;;; instructions ;;;;
		  1	[ 53]	UGET 	  1		0	; slot1 = uv0"wave_db"
		  2	[ 53]	TGETS	  1	1	6	; slot1 = uv0"wave_db".parse_errors
		  3	[ 53]	IST  	   		1	; if uv0"wave_db".parse_errors
		  4	[ 53]	JMP  	  1		3	; 	goto 8
		  5	[ 54]	UGET 	  1		0	; slot1 = uv0"wave_db"
		  6	[ 54]	TNEW 	  2		0	; slot2 = new table( array: 0, dict: 1)
		  7	[ 54]	TSETS	  2	1	6	; uv0"wave_db".parse_errors = slot2
		  8	[ 56]	GGET 	  1		5	; slot1 = _env["table"]
		  9	[ 56]	TGETS	  1	1	4	; slot1 = table.insert
		 10	[ 56]	UGET 	  2		0	; slot2 = uv0"wave_db"
		 11	[ 56]	TGETS	  2	2	6	; slot2 = uv0"wave_db".parse_errors
		 12	[ 56]	GGET 	  3		3	; slot3 = _env["string"]
		 13	[ 56]	TGETS	  3	3	2	; slot3 = string.format
		 14	[ 56]	ISTC 	  4		0	; slot4 = fmt; if fmt
		 15	[ 56]	JMP  	  4		1	; 	goto 17
		 16	[ 56]	KSTR 	  4		1	; slot4 = ""
		 17	[ 56]	VARG 	  5	0	1	; MULTRES = ...
		 18	[ 56]	CALLM	  3	0	1	; MULTRES = string.format(slot4, ...MULTRES)
		 19	[ 56]	CALLM	  1	1	1	;  = table.insert(uv0"wave_db".parse_errors, ...MULTRES)
		 20	[ 57]	UGET 	  1		1	; slot1 = uv1"log"
		 21	[ 57]	TGETS	  1	1	0	; slot1 = uv1"log".error
		 22	[ 57]	MOV  	  2		0	; slot2 = fmt
		 23	[ 57]	VARG 	  3	0	1	; MULTRES = ...
		 24	[ 57]	CALLM	  1	1	1	;  = uv1"log".error(fmt, ...MULTRES)
		 25	[ 58]	RET0 	  0		1	; return
	 73	[112]	FNEW 	 14		128	; @./all/wave_db.lua:65-112: 4 args, 0 upvalues, 19 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-70:	self
		  0-70:	cmd
		  0-70:	row
		  0-70:	row_idx
		  1-70:	col_letter
		  2-70:	time_columns
		  3-70:	path_columns
		  6-67:	<generator>
		  6-67:	<state>
		  6-67:	<control>
		  7-65:	i
		  7-65:	col
		  22-65:	parts
		  40-53:	pi
		  46-53:	spi
		;;;; instructions ;;;;
		  1	[ 78]	FNEW 	  4		15	; @./all/wave_db.lua:66-78: 1 args, 0 upvalues, 9 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			;;;; variable info ;;;;
			  0-30:	idx
			  4-30:	first
			  8-30:	last
			  10-30:	base
			  11-30:	r
			  12-30:	q
			  17-28:	rem
			;;;; instructions ;;;;
			  1	[ 67]	GGET 	  1		7	; slot1 = _env["string"]
			  2	[ 67]	TGETS	  1	1	6	; slot1 = string.byte
			  3	[ 67]	KSTR 	  2		5	; slot2 = "A"
			  4	[ 67]	CALL 	  1	2	2	; slot1 = string.byte(slot2)
			  5	[ 68]	GGET 	  2		7	; slot2 = _env["string"]
			  6	[ 68]	TGETS	  2	2	6	; slot2 = string.byte
			  7	[ 68]	KSTR 	  3		4	; slot3 = "Z"
			  8	[ 68]	CALL 	  2	2	2	; slot2 = string.byte(slot3)
			  9	[ 69]	SUBVV	  3	2	1	; slot3 = last - first
			 10	[ 69]	ADDVN	  3	3	0	; slot3 = slot3 + 1
			 11	[ 70]	KSTR 	  4		3	; slot4 = ""
			 12	[ 71]	SUBVN	  5	0	0	; slot5 = idx - 1
			 13	[ 72]	KSHORT	  6		0	; slot6 = 0
			 14	[ 72]	ISGT 	  6		5	; if slot6 > q
			 15	[ 72]	JMP  	  6		14	; 	goto 30
			 16	[ 72]	LOOP 	  6		13	; Loop start, exit goto 30
			 17	[ 73]	MODVV	  6	5	3	; slot6 = q % base
			 18	[ 74]	GGET 	  7		7	; slot7 = _env["string"]
			 19	[ 74]	TGETS	  7	7	2	; slot7 = string.char
			 20	[ 74]	ADDVV	  8	6	1	; slot8 = rem + first
			 21	[ 74]	CALL 	  7	2	2	; slot7 = string.char(slot8)
			 22	[ 74]	MOV  	  8		4	; slot8 = r
			 23	[ 74]	CAT  	  4	7	8	; slot4 = string.char .. r
			 24	[ 75]	GGET 	  7		1	; slot7 = _env["math"]
			 25	[ 75]	TGETS	  7	7	0	; slot7 = math.floor
			 26	[ 75]	DIVVV	  8	5	3	; slot8 = q / base
			 27	[ 75]	CALL 	  7	2	2	; slot7 = math.floor(slot8)
			 28	[ 75]	SUBVN	  5	7	0	; slot5 = math.floor - 1
			 29	[ 75]	JMP  	  6		-17	; 	goto 13
			 30	[ 77]	RET1 	  4		2	; return r
		  2	[ 80]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		  3	[ 81]	TNEW 	  6		0	; slot6 = new table( array: 0, dict: 1)
		  4	[ 84]	GGET 	  7		14	; slot7 = _env["ipairs"]
		  5	[ 84]	MOV  	  8		2	; slot8 = row
		  6	[ 84]	CALL 	  7	4	2	; slot7, slot8, slot9 = ipairs(row)
		  7	[ 84]	JMP  	 10		58	; 	goto 66
		  8	[ 85]	GGET 	 12		13	; slot12 = _env["string"]
		  9	[ 85]	TGETS	 12	12	12	; slot12 = string.trim
		 10	[ 85]	MOV  	 13		11	; slot13 = col
		 11	[ 85]	CALL 	 12	2	2	; slot12 = string.trim(col)
		 12	[ 85]	MOV  	 11		12	; slot11 = string.trim
		 13	[ 86]	ISEQS	 11		11	; if col == "column_names"
		 14	[ 86]	JMP  	 12		51	; 	goto 66
		 15	[ 86]	ISNES	 11		10	; if col ~= ""
		 16	[ 86]	JMP  	 12		1	; 	goto 18
		 17	[ 87]	JMP  	 12		48	; 	goto 66
		 18	[ 89]	GGET 	 12		13	; slot12 = _env["string"]
		 19	[ 89]	TGETS	 12	12	9	; slot12 = string.split
		 20	[ 89]	MOV  	 13		11	; slot13 = col
		 21	[ 89]	KSTR 	 14		8	; slot14 = ":"
		 22	[ 89]	CALL 	 12	2	3	; slot12 = string.split(col, slot14)
		 23	[ 90]	TGETB	 13	12	1	; slot13 = parts[1]
		 24	[ 90]	ISNES	 13		7	; if slot13 ~= "inc"
		 25	[ 90]	JMP  	 13		2	; 	goto 28
		 26	[ 92]	TSETS	 10	5	7	; time_columns.inc = i
		 27	[ 92]	JMP  	 13		38	; 	goto 66
		 28	[ 93]	TGETB	 13	12	1	; slot13 = parts[1]
		 29	[ 93]	ISNES	 13		6	; if slot13 ~= "abs"
		 30	[ 93]	JMP  	 13		2	; 	goto 33
		 31	[ 95]	TSETS	 10	5	6	; time_columns.abs = i
		 32	[ 95]	JMP  	 13		33	; 	goto 66
		 33	[ 96]	GGET 	 13		5	; slot13 = _env["tonumber"]
		 34	[ 96]	TGETB	 14	12	1	; slot14 = parts[1]
		 35	[ 96]	CALL 	 13	2	2	; slot13 = tonumber(slot14)
		 36	[ 96]	ISF  	   		13	; if not tonumber
		 37	[ 96]	JMP  	 14		17	; 	goto 55
		 38	[ 98]	GGET 	 13		5	; slot13 = _env["tonumber"]
		 39	[ 98]	TGETB	 14	12	1	; slot14 = parts[1]
		 40	[ 98]	CALL 	 13	2	2	; slot13 = tonumber(slot14)
		 41	[ 99]	GGET 	 14		5	; slot14 = _env["tonumber"]
		 42	[ 99]	TGETB	 15	12	2	; slot15 = parts[2]
		 43	[ 99]	CALL 	 14	2	2	; slot14 = tonumber(slot15)
		 44	[ 99]	IST  	   		14	; if tonumber
		 45	[ 99]	JMP  	 15		1	; 	goto 47
		 46	[ 99]	KSTR 	 14		4	; slot14 = "*"
		 47	[100]	TGETV	 15	6	13	; slot15 = path_columns[pi]
		 48	[100]	IST  	   		15	; if slot15
		 49	[100]	JMP  	 16		1	; 	goto 51
		 50	[100]	TNEW 	 15		0	; slot15 = new table( array: 0, dict: 1)
		 51	[100]	TSETV	 15	6	13	; path_columns[pi] = slot15
		 52	[101]	TGETV	 15	6	13	; slot15 = path_columns[pi]
		 53	[101]	TSETV	 10	15	14	; slot15[spi] = i
		 54	[101]	JMP  	 13		11	; 	goto 66
		 55	[104]	KPRI 	 13		2	; slot13 = true
		 56	[104]	GGET 	 14		13	; slot14 = _env["string"]
		 57	[104]	TGETS	 14	14	3	; slot14 = string.format
		 58	[104]	KSTR 	 15		2	; slot15 = "unknown column type: %s at column %s"
		 59	[104]	MOV  	 16		11	; slot16 = col
		 60	[104]	MOV  	 17		4	; slot17 = col_letter
		 61	[104]	MOV  	 18		10	; slot18 = i
		 62	[104]	CALL 	 17	0	2	; MULTRES = col_letter(i)
		 63	[104]	CALLM	 14	0	2	; MULTRES = string.format(slot15, col, ...MULTRES)
		 64	[104]	UCLO 	  0		0	; nil uvs >= r0; goto 65
		 65	[104]	RETM 	 13		1	; return , ...MULTRES
		 66	[ 84]	ITERC	 10	3	3	; slot10, slot11, slot12 = slot7<generator>, slot8<state>, slot9<control>; slot10, slot11 = slot7<generator>(slot8<state>, slot9<control>)
		 67	[ 84]	ITERL	 10		-60	; slot9<control> = slot10; if slot10 != nil goto 8
		 68	[110]	TSETS	  5	1	1	; cmd.time_columns = time_columns
		 69	[111]	TSETS	  6	1	0	; cmd.path_columns = path_columns
		 70	[112]	RET0 	  0		1	; return
	 74	[ 65]	TSETS	 14	5	129	; wave_db.parse_column_names = slot14
	 75	[144]	FNEW 	 14		126	; @./all/wave_db.lua:114-144: 4 args, 0 upvalues, 20 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-66:	self
		  0-66:	cmd
		  0-66:	row
		  0-66:	row_idx
		  5-66:	cmd_cols
		  11-66:	pc
		  17-66:	out
		  20-64:	<generator>
		  20-64:	<state>
		  20-64:	<control>
		  21-62:	pi
		  26-62:	<generator>
		  26-62:	<state>
		  26-62:	<control>
		  27-60:	spi
		  27-60:	col_index
		  34-60:	flag
		  45-60:	v
		  58-60:	spin
		;;;; instructions ;;;;
		  1	[115]	MOV  	  5		0	; slot5 = self
		  2	[115]	TGETS	  4	0	15	; slot4 = self.find_prev_cmd
		  3	[115]	KSTR 	  6		14	; slot6 = "column_names"
		  4	[115]	MOV  	  7		1	; slot7 = cmd
		  5	[115]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[116]	IST  	   		4	; if cmd_cols
		  7	[116]	JMP  	  5		3	; 	goto 11
		  8	[117]	KPRI 	  5		2	; slot5 = true
		  9	[117]	KSTR 	  6		13	; slot6 = "flags cmd requires a path command before"
		 10	[117]	RET  	  5		3	; return slot5, slot6
		 11	[120]	TGETS	  5	4	12	; slot5 = cmd_cols.path_columns
		 12	[121]	IST  	   		5	; if pc
		 13	[121]	JMP  	  6		3	; 	goto 17
		 14	[122]	KPRI 	  6		2	; slot6 = true
		 15	[122]	KSTR 	  7		11	; slot7 = "flags cmd requires path cmd with path_columns"
		 16	[122]	RET  	  6		3	; return slot6, slot7
		 17	[125]	TNEW 	  6		0	; slot6 = new table( array: 0, dict: 1)
		 18	[126]	GGET 	  7		10	; slot7 = _env["pairs"]
		 19	[126]	MOV  	  8		5	; slot8 = pc
		 20	[126]	CALL 	  7	4	2	; slot7, slot8, slot9 = pairs(pc)
		 21	[126]	ISNEXT	 10		41	; Verify ITERN at 63; goto 63
		 22	[127]	TNEW 	 11		0	; slot11 = new table( array: 0, dict: 1)
		 23	[127]	TSETV	 11	6	10	; out[pi] = slot11
		 24	[128]	GGET 	 11		10	; slot11 = _env["pairs"]
		 25	[128]	TGETV	 12	5	10	; slot12 = pc[pi]
		 26	[128]	CALL 	 11	4	2	; slot11, slot12, slot13 = pairs(slot12)
		 27	[128]	ISNEXT	 14		33	; Verify ITERN at 61; goto 61
		 28	[129]	GGET 	 16		9	; slot16 = _env["string"]
		 29	[129]	TGETS	 16	16	8	; slot16 = string.lower
		 30	[129]	TGETV	 17	2	15	; slot17 = row[col_index]
		 31	[129]	IST  	   		17	; if slot17
		 32	[129]	JMP  	 18		1	; 	goto 34
		 33	[129]	KSTR 	 17		7	; slot17 = ""
		 34	[129]	CALL 	 16	2	2	; slot16 = string.lower(slot17)
		 35	[130]	ISEQS	 16		6	; if flag == "n"
		 36	[130]	JMP  	 17		6	; 	goto 43
		 37	[130]	ISEQS	 16		5	; if flag == "false"
		 38	[130]	JMP  	 17		4	; 	goto 43
		 39	[130]	ISEQS	 16		4	; if flag == "hide"
		 40	[130]	JMP  	 17		2	; 	goto 43
		 41	[130]	ISNES	 16		3	; if flag ~= "hidden"
		 42	[130]	JMP  	 17		2	; 	goto 45
		 43	[130]	KPRI 	 17		1	; slot17 = false
		 44	[130]	JMP  	 18		1	; 	goto 46
		 45	[130]	KPRI 	 17		2	; slot17 = true
		 46	[131]	ISNES	 14		2	; if spi ~= "*"
		 47	[131]	JMP  	 18		8	; 	goto 56
		 48	[132]	TGETV	 18	6	10	; slot18 = out[pi]
		 49	[132]	TSETB	 17	18	1	; slot18[1] = v
		 50	[133]	TGETV	 18	6	10	; slot18 = out[pi]
		 51	[133]	TSETB	 17	18	2	; slot18[2] = v
		 52	[134]	TGETV	 18	6	10	; slot18 = out[pi]
		 53	[134]	TSETB	 17	18	3	; slot18[3] = v
		 54	[135]	JMP  	 11		8	; 	goto 63
		 55	[135]	JMP  	 18		5	; 	goto 61
		 56	[137]	GGET 	 18		1	; slot18 = _env["tonumber"]
		 57	[137]	MOV  	 19		14	; slot19 = spi
		 58	[137]	CALL 	 18	2	2	; slot18 = tonumber(spi)
		 59	[138]	TGETV	 19	6	10	; slot19 = out[pi]
		 60	[138]	TSETV	 17	19	18	; slot19[spin] = v
		 61	[128]	ITERN	 14	3	3	; slot14, slot15, slot16 = slot11<generator>, slot12<state>, slot13<control>; slot14, slot15 = slot11<generator>(slot12<state>, slot13<control>)
		 62	[128]	ITERL	 14		-35	; slot13<control> = slot14; if slot14 != nil goto 28
		 63	[126]	ITERN	 10	2	3	; slot10, slot11, slot12 = slot7<generator>, slot8<state>, slot9<control>; slot10 = slot7<generator>(slot8<state>, slot9<control>)
		 64	[126]	ITERL	 10		-43	; slot9<control> = slot10; if slot10 != nil goto 22
		 65	[143]	TSETS	  6	1	0	; cmd.flags_visibility = out
		 66	[144]	RET0 	  0		1	; return
	 76	[114]	TSETS	 14	5	127	; wave_db.parse_flags = slot14
	 77	[158]	FNEW 	 14		124	; @./all/wave_db.lua:146-158: 4 args, 0 upvalues, 10 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-41:	self
		  0-41:	cmd
		  0-41:	row
		  0-41:	row_idx
		  5-41:	cmd_cols
		  19-41:	cmd_i
		  24-41:	cmd_di
		  25-41:	tc
		;;;; instructions ;;;;
		  1	[147]	MOV  	  5		0	; slot5 = self
		  2	[147]	TGETS	  4	0	12	; slot4 = self.find_prev_cmd
		  3	[147]	KSTR 	  6		11	; slot6 = "column_names"
		  4	[147]	MOV  	  7		1	; slot7 = cmd
		  5	[147]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[148]	IST  	   		4	; if cmd_cols
		  7	[148]	JMP  	  5		7	; 	goto 15
		  8	[149]	KPRI 	  5		2	; slot5 = true
		  9	[149]	GGET 	  6		10	; slot6 = _env["string"]
		 10	[149]	TGETS	  6	6	9	; slot6 = string.format
		 11	[149]	KSTR 	  7		8	; slot7 = "%s cmd requires a path command before"
		 12	[149]	TGETS	  8	1	7	; slot8 = cmd.name
		 13	[149]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[149]	RETM 	  5		1	; return , ...MULTRES
		 15	[153]	MOV  	  6		0	; slot6 = self
		 16	[153]	TGETS	  5	0	12	; slot5 = self.find_prev_cmd
		 17	[153]	KSTR 	  7		6	; slot7 = "interval"
		 18	[153]	MOV  	  8		1	; slot8 = cmd
		 19	[153]	CALL 	  5	2	4	; slot5 = self.find_prev_cmd(self, slot7, cmd)
		 20	[154]	MOV  	  7		0	; slot7 = self
		 21	[154]	TGETS	  6	0	12	; slot6 = self.find_prev_cmd
		 22	[154]	KSTR 	  8		5	; slot8 = "default_interval"
		 23	[154]	MOV  	  9		1	; slot9 = cmd
		 24	[154]	CALL 	  6	2	4	; slot6 = self.find_prev_cmd(self, slot8, cmd)
		 25	[155]	TGETS	  7	4	4	; slot7 = cmd_cols.time_columns
		 26	[157]	GGET 	  8		2	; slot8 = _env["tonumber"]
		 27	[157]	TGETS	  9	7	1	; slot9 = tc.inc
		 28	[157]	TGETV	  9	2	9	; slot9 = row[tc.inc]
		 29	[157]	CALL 	  8	2	2	; slot8 = tonumber(slot9)
		 30	[157]	IST  	   		8	; if tonumber
		 31	[157]	JMP  	  9		8	; 	goto 40
		 32	[157]	ISF  	   		5	; if not cmd_i
		 33	[157]	JMP  	  8		3	; 	goto 37
		 34	[157]	TGETS	  8	5	0	; slot8 = cmd_i.value
		 35	[157]	IST  	   		8	; if cmd_i.value
		 36	[157]	JMP  	  9		3	; 	goto 40
		 37	[157]	ISFC 	  8		6	; slot8 = cmd_di; if not cmd_di
		 38	[157]	JMP  	  8		1	; 	goto 40
		 39	[157]	TGETS	  8	6	0	; slot8 = cmd_di.value
		 40	[157]	TSETS	  8	1	3	; cmd.wait_time = cmd_di.value
		 41	[158]	RET0 	  0		1	; return
	 78	[146]	TSETS	 14	5	125	; wave_db.parse_wave = slot14
	 79	[190]	FNEW 	 14		122	; @./all/wave_db.lua:160-190: 4 args, 0 upvalues, 27 slots
		
		;;;; constant tables ;;;;
		ktable#3 = [
			]
		
		
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-85:	self
		  0-85:	cmd
		  0-85:	row
		  0-85:	row_idx
		  5-85:	cmd_cols
		  19-85:	cmd_enemy_prefix
		  23-85:	enemy_prefix
		  28-85:	cmd_default_increment
		  32-85:	default_increment
		  33-85:	tc
		  37-85:	row_increment
		  47-85:	pc
		  50-84:	<generator>
		  50-84:	<state>
		  50-84:	<control>
		  51-82:	pi
		  54-82:	<generator>
		  54-82:	<state>
		  54-82:	<control>
		  55-80:	spi
		  55-80:	col_index
		  65-80:	enemy_suffix
		;;;; instructions ;;;;
		  1	[161]	MOV  	  5		0	; slot5 = self
		  2	[161]	TGETS	  4	0	25	; slot4 = self.find_prev_cmd
		  3	[161]	KSTR 	  6		24	; slot6 = "column_names"
		  4	[161]	MOV  	  7		1	; slot7 = cmd
		  5	[161]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[162]	IST  	   		4	; if cmd_cols
		  7	[162]	JMP  	  5		7	; 	goto 15
		  8	[163]	KPRI 	  5		2	; slot5 = true
		  9	[163]	GGET 	  6		23	; slot6 = _env["string"]
		 10	[163]	TGETS	  6	6	22	; slot6 = string.format
		 11	[163]	KSTR 	  7		21	; slot7 = "%s cmd requires a path command before"
		 12	[163]	TGETS	  8	1	20	; slot8 = cmd.name
		 13	[163]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[163]	RETM 	  5		1	; return , ...MULTRES
		 15	[166]	MOV  	  6		0	; slot6 = self
		 16	[166]	TGETS	  5	0	25	; slot5 = self.find_prev_cmd
		 17	[166]	KSTR 	  7		19	; slot7 = "enemy_prefix"
		 18	[166]	MOV  	  8		1	; slot8 = cmd
		 19	[166]	CALL 	  5	2	4	; slot5 = self.find_prev_cmd(self, slot7, cmd)
		 20	[167]	TGETS	  6	5	18	; slot6 = cmd_enemy_prefix.value
		 21	[167]	IST  	   		6	; if cmd_enemy_prefix.value
		 22	[167]	JMP  	  7		1	; 	goto 24
		 23	[167]	KSTR 	  6		17	; slot6 = ""
		 24	[170]	MOV  	  8		0	; slot8 = self
		 25	[170]	TGETS	  7	0	25	; slot7 = self.find_prev_cmd
		 26	[170]	KSTR 	  9		16	; slot9 = "default_increment"
		 27	[170]	MOV  	 10		1	; slot10 = cmd
		 28	[170]	CALL 	  7	2	4	; slot7 = self.find_prev_cmd(self, slot9, cmd)
		 29	[171]	TGETS	  8	7	18	; slot8 = cmd_default_increment.value
		 30	[171]	IST  	   		8	; if cmd_default_increment.value
		 31	[171]	JMP  	  9		1	; 	goto 33
		 32	[171]	KSHORT	  8		1	; slot8 = 1
		 33	[173]	TGETS	  9	4	15	; slot9 = cmd_cols.time_columns
		 34	[174]	GGET 	 10		14	; slot10 = _env["tonumber"]
		 35	[174]	TGETS	 11	9	13	; slot11 = tc.inc
		 36	[174]	TGETV	 11	2	11	; slot11 = row[tc.inc]
		 37	[174]	CALL 	 10	2	2	; slot10 = tonumber(slot11)
		 38	[176]	ISTC 	 11		10	; slot11 = row_increment; if row_increment
		 39	[176]	JMP  	 11		1	; 	goto 41
		 40	[176]	MOV  	 11		8	; slot11 = default_increment
		 41	[176]	TSETS	 11	1	12	; cmd.wait_time = default_increment
		 42	[177]	TGETS	 11	9	10	; slot11 = tc.abs
		 43	[177]	TGETV	 11	2	11	; slot11 = row[tc.abs]
		 44	[177]	TSETS	 11	1	11	; cmd.absolute = slot11
		 45	[180]	TNEW 	 11		0	; slot11 = new table( array: 0, dict: 1)
		 46	[180]	TSETS	 11	1	9	; cmd.spawns = slot11
		 47	[181]	TGETS	 11	4	8	; slot11 = cmd_cols.path_columns
		 48	[182]	GGET 	 12		7	; slot12 = _env["pairs"]
		 49	[182]	MOV  	 13		11	; slot13 = pc
		 50	[182]	CALL 	 12	4	2	; slot12, slot13, slot14 = pairs(pc)
		 51	[182]	ISNEXT	 15		31	; Verify ITERN at 83; goto 83
		 52	[183]	GGET 	 16		7	; slot16 = _env["pairs"]
		 53	[183]	TGETV	 17	11	15	; slot17 = pc[pi]
		 54	[183]	CALL 	 16	4	2	; slot16, slot17, slot18 = pairs(slot17)
		 55	[183]	ISNEXT	 19		25	; Verify ITERN at 81; goto 81
		 56	[184]	TGETV	 21	2	20	; slot21 = row[col_index]
		 57	[184]	ISF  	   		21	; if not slot21
		 58	[184]	JMP  	 22		6	; 	goto 65
		 59	[184]	GGET 	 21		23	; slot21 = _env["string"]
		 60	[184]	TGETS	 21	21	6	; slot21 = string.trim
		 61	[184]	TGETV	 22	2	20	; slot22 = row[col_index]
		 62	[184]	CALL 	 21	2	2	; slot21 = string.trim(slot22)
		 63	[184]	IST  	   		21	; if string.trim
		 64	[184]	JMP  	 22		1	; 	goto 66
		 65	[184]	KSTR 	 21		17	; slot21 = ""
		 66	[185]	ISF  	   		21	; if not enemy_suffix
		 67	[185]	JMP  	 22		13	; 	goto 81
		 68	[185]	ISEQS	 21		17	; if enemy_suffix == ""
		 69	[185]	JMP  	 22		11	; 	goto 81
		 70	[186]	GGET 	 22		5	; slot22 = _env["table"]
		 71	[186]	TGETS	 22	22	4	; slot22 = table.insert
		 72	[186]	TGETS	 23	1	9	; slot23 = cmd.spawns
		 73	[186]	TDUP 	 24		3	; slot24 = copy table#k3
		 74	[186]	TSETS	 15	24	2	; slot24.pi = pi
		 75	[186]	TSETS	 19	24	1	; slot24.spi = spi
		 76	[186]	MOV  	 25		6	; slot25 = enemy_prefix
		 77	[186]	MOV  	 26		21	; slot26 = enemy_suffix
		 78	[186]	CAT  	 25	25	26	; slot25 = enemy_prefix .. enemy_suffix
		 79	[186]	TSETS	 25	24	0	; slot24.enemy = slot25
		 80	[186]	CALL 	 22	1	3	;  = table.insert(cmd.spawns, slot24)
		 81	[183]	ITERN	 19	3	3	; slot19, slot20, slot21 = slot16<generator>, slot17<state>, slot18<control>; slot19, slot20 = slot16<generator>(slot17<state>, slot18<control>)
		 82	[183]	ITERL	 19		-27	; slot18<control> = slot19; if slot19 != nil goto 56
		 83	[182]	ITERN	 15	2	3	; slot15, slot16, slot17 = slot12<generator>, slot13<state>, slot14<control>; slot15 = slot12<generator>(slot13<state>, slot14<control>)
		 84	[182]	ITERL	 15		-33	; slot14<control> = slot15; if slot15 != nil goto 52
		 85	[190]	RET0 	  0		1	; return
	 80	[160]	TSETS	 14	5	123	; wave_db.parse_spawn = slot14
	 81	[213]	FNEW 	 14		120	; @./all/wave_db.lua:192-213: 4 args, 1 upvalues, 17 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	tsv_value_col
		;;;; variable info ;;;;
		  0-54:	self
		  0-54:	cmd
		  0-54:	row
		  0-54:	row_idx
		  5-54:	cmd_cols
		  19-54:	cmd_default_increment
		  23-54:	default_increment
		  25-54:	event_name
		  31-54:	increment
		  32-54:	params
		  36-47:	<index>
		  36-47:	<limit>
		  36-47:	<step>
		  37-46:	i
		;;;; instructions ;;;;
		  1	[193]	MOV  	  5		0	; slot5 = self
		  2	[193]	TGETS	  4	0	15	; slot4 = self.find_prev_cmd
		  3	[193]	KSTR 	  6		14	; slot6 = "column_names"
		  4	[193]	MOV  	  7		1	; slot7 = cmd
		  5	[193]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[194]	IST  	   		4	; if cmd_cols
		  7	[194]	JMP  	  5		7	; 	goto 15
		  8	[195]	KPRI 	  5		2	; slot5 = true
		  9	[195]	GGET 	  6		13	; slot6 = _env["string"]
		 10	[195]	TGETS	  6	6	12	; slot6 = string.format
		 11	[195]	KSTR 	  7		11	; slot7 = "%s cmd requires a path command before"
		 12	[195]	TGETS	  8	1	10	; slot8 = cmd.name
		 13	[195]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[195]	RETM 	  5		1	; return , ...MULTRES
		 15	[197]	MOV  	  6		0	; slot6 = self
		 16	[197]	TGETS	  5	0	15	; slot5 = self.find_prev_cmd
		 17	[197]	KSTR 	  7		9	; slot7 = "default_increment"
		 18	[197]	MOV  	  8		1	; slot8 = cmd
		 19	[197]	CALL 	  5	2	4	; slot5 = self.find_prev_cmd(self, slot7, cmd)
		 20	[198]	TGETS	  6	5	8	; slot6 = cmd_default_increment.value
		 21	[198]	IST  	   		6	; if cmd_default_increment.value
		 22	[198]	JMP  	  7		1	; 	goto 24
		 23	[198]	KSHORT	  6		1	; slot6 = 1
		 24	[200]	UGET 	  7		0	; slot7 = uv0"tsv_value_col"
		 25	[200]	TGETV	  7	2	7	; slot7 = row[uv0"tsv_value_col"]
		 26	[201]	TGETS	  8	4	7	; slot8 = cmd_cols.time_columns
		 27	[201]	TGETS	  8	8	6	; slot8 = cmd_cols.time_columns.inc
		 28	[201]	TGETV	  8	2	8	; slot8 = row[cmd_cols.time_columns.inc]
		 29	[201]	IST  	   		8	; if slot8
		 30	[201]	JMP  	  9		1	; 	goto 32
		 31	[201]	MOV  	  8		6	; slot8 = default_increment
		 32	[203]	TNEW 	  9		0	; slot9 = new table( array: 0, dict: 1)
		 33	[204]	UGET 	 10		0	; slot10 = uv0"tsv_value_col"
		 34	[204]	ADDVN	 10	10	0	; slot10 = uv0"tsv_value_col" + 1
		 35	[204]	LEN  	 11		2	; slot11 = #row
		 36	[204]	KSHORT	 12		1	; slot12 = 1
		 37	[204]	FORI 	 10		10	; for slot13 = slot10,slot11,slot12 else goto 48
		 38	[205]	TGETS	 14	4	7	; slot14 = cmd_cols.time_columns
		 39	[205]	TGETS	 14	14	6	; slot14 = cmd_cols.time_columns.inc
		 40	[205]	ISEQV	 13		14	; if i == cmd_cols.time_columns.inc
		 41	[205]	JMP  	 14		5	; 	goto 47
		 42	[206]	GGET 	 14		5	; slot14 = _env["table"]
		 43	[206]	TGETS	 14	14	4	; slot14 = table.insert
		 44	[206]	MOV  	 15		9	; slot15 = params
		 45	[206]	TGETV	 16	2	13	; slot16 = row[i]
		 46	[206]	CALL 	 14	1	3	;  = table.insert(params, slot16)
		 47	[204]	FORL 	 10		-10	; slot13 = slot13 + slot12<step>; if cmp(slot13, sign slot12<step>,  slot11<limit>) goto 38
		 48	[210]	TSETS	  7	1	3	; cmd.event_name = event_name
		 49	[211]	TSETS	  9	1	2	; cmd.event_params = params
		 50	[212]	GGET 	 10		0	; slot10 = _env["tonumber"]
		 51	[212]	MOV  	 11		8	; slot11 = increment
		 52	[212]	CALL 	 10	2	2	; slot10 = tonumber(increment)
		 53	[212]	TSETS	 10	1	1	; cmd.wait_time = tonumber
		 54	[213]	RET0 	  0		1	; return
	 82	[192]	TSETS	 14	5	121	; wave_db.parse_event = slot14
	 83	[237]	FNEW 	 14		118	; @./all/wave_db.lua:215-237: 4 args, 1 upvalues, 17 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	tsv_value_col
		;;;; variable info ;;;;
		  0-54:	self
		  0-54:	cmd
		  0-54:	row
		  0-54:	row_idx
		  5-54:	cmd_cols
		  19-54:	cmd_default_increment
		  23-54:	default_increment
		  25-54:	signal_name
		  31-54:	increment
		  32-54:	params
		  36-47:	<index>
		  36-47:	<limit>
		  36-47:	<step>
		  37-46:	i
		;;;; instructions ;;;;
		  1	[216]	MOV  	  5		0	; slot5 = self
		  2	[216]	TGETS	  4	0	16	; slot4 = self.find_prev_cmd
		  3	[216]	KSTR 	  6		15	; slot6 = "column_names"
		  4	[216]	MOV  	  7		1	; slot7 = cmd
		  5	[216]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[217]	IST  	   		4	; if cmd_cols
		  7	[217]	JMP  	  5		7	; 	goto 15
		  8	[218]	KPRI 	  5		2	; slot5 = true
		  9	[218]	GGET 	  6		14	; slot6 = _env["string"]
		 10	[218]	TGETS	  6	6	13	; slot6 = string.format
		 11	[218]	KSTR 	  7		12	; slot7 = "%s cmd requires a path command before"
		 12	[218]	TGETS	  8	1	11	; slot8 = cmd.name
		 13	[218]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[218]	RETM 	  5		1	; return , ...MULTRES
		 15	[220]	MOV  	  6		0	; slot6 = self
		 16	[220]	TGETS	  5	0	16	; slot5 = self.find_prev_cmd
		 17	[220]	KSTR 	  7		10	; slot7 = "default_increment"
		 18	[220]	MOV  	  8		1	; slot8 = cmd
		 19	[220]	CALL 	  5	2	4	; slot5 = self.find_prev_cmd(self, slot7, cmd)
		 20	[221]	TGETS	  6	5	9	; slot6 = cmd_default_increment.value
		 21	[221]	IST  	   		6	; if cmd_default_increment.value
		 22	[221]	JMP  	  7		1	; 	goto 24
		 23	[221]	KSHORT	  6		1	; slot6 = 1
		 24	[223]	UGET 	  7		0	; slot7 = uv0"tsv_value_col"
		 25	[223]	TGETV	  7	2	7	; slot7 = row[uv0"tsv_value_col"]
		 26	[224]	TGETS	  8	4	8	; slot8 = cmd_cols.time_columns
		 27	[224]	TGETS	  8	8	7	; slot8 = cmd_cols.time_columns.inc
		 28	[224]	TGETV	  8	2	8	; slot8 = row[cmd_cols.time_columns.inc]
		 29	[224]	IST  	   		8	; if slot8
		 30	[224]	JMP  	  9		1	; 	goto 32
		 31	[224]	MOV  	  8		6	; slot8 = default_increment
		 32	[226]	TNEW 	  9		0	; slot9 = new table( array: 0, dict: 1)
		 33	[227]	UGET 	 10		0	; slot10 = uv0"tsv_value_col"
		 34	[227]	ADDVN	 10	10	0	; slot10 = uv0"tsv_value_col" + 1
		 35	[227]	LEN  	 11		2	; slot11 = #row
		 36	[227]	KSHORT	 12		1	; slot12 = 1
		 37	[227]	FORI 	 10		10	; for slot13 = slot10,slot11,slot12 else goto 48
		 38	[229]	TGETS	 14	4	6	; slot14 = cmd_cols.path_columns
		 39	[229]	TGETS	 14	14	7	; slot14 = cmd_cols.path_columns.inc
		 40	[229]	ISEQV	 13		14	; if i == cmd_cols.path_columns.inc
		 41	[229]	JMP  	 14		5	; 	goto 47
		 42	[230]	GGET 	 14		5	; slot14 = _env["table"]
		 43	[230]	TGETS	 14	14	4	; slot14 = table.insert
		 44	[230]	MOV  	 15		9	; slot15 = params
		 45	[230]	TGETV	 16	2	13	; slot16 = row[i]
		 46	[230]	CALL 	 14	1	3	;  = table.insert(params, slot16)
		 47	[227]	FORL 	 10		-10	; slot13 = slot13 + slot12<step>; if cmp(slot13, sign slot12<step>,  slot11<limit>) goto 38
		 48	[234]	TSETS	  7	1	3	; cmd.signal_name = signal_name
		 49	[235]	TSETS	  9	1	2	; cmd.signal_params = params
		 50	[236]	GGET 	 10		0	; slot10 = _env["tonumber"]
		 51	[236]	MOV  	 11		8	; slot11 = increment
		 52	[236]	CALL 	 10	2	2	; slot10 = tonumber(increment)
		 53	[236]	TSETS	 10	1	1	; cmd.wait_time = tonumber
		 54	[237]	RET0 	  0		1	; return
	 84	[215]	TSETS	 14	5	119	; wave_db.parse_signal = slot14
	 85	[253]	FNEW 	 14		116	; @./all/wave_db.lua:239-253: 4 args, 2 upvalues, 12 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	tsv_value_col
		  1:	log
		;;;; variable info ;;;;
		  0-42:	self
		  0-42:	cmd
		  0-42:	row
		  0-42:	row_idx
		  5-42:	cmd_cols
		  19-42:	cmd_default_increment
		  23-42:	default_increment
		  25-42:	signal_name
		  31-42:	increment
		;;;; instructions ;;;;
		  1	[240]	MOV  	  5		0	; slot5 = self
		  2	[240]	TGETS	  4	0	14	; slot4 = self.find_prev_cmd
		  3	[240]	KSTR 	  6		13	; slot6 = "column_names"
		  4	[240]	MOV  	  7		1	; slot7 = cmd
		  5	[240]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[241]	IST  	   		4	; if cmd_cols
		  7	[241]	JMP  	  5		7	; 	goto 15
		  8	[242]	KPRI 	  5		2	; slot5 = true
		  9	[242]	GGET 	  6		12	; slot6 = _env["string"]
		 10	[242]	TGETS	  6	6	11	; slot6 = string.format
		 11	[242]	KSTR 	  7		10	; slot7 = "%s cmd requires a path command before"
		 12	[242]	TGETS	  8	1	9	; slot8 = cmd.name
		 13	[242]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[242]	RETM 	  5		1	; return , ...MULTRES
		 15	[244]	MOV  	  6		0	; slot6 = self
		 16	[244]	TGETS	  5	0	14	; slot5 = self.find_prev_cmd
		 17	[244]	KSTR 	  7		8	; slot7 = "default_increment"
		 18	[244]	MOV  	  8		1	; slot8 = cmd
		 19	[244]	CALL 	  5	2	4	; slot5 = self.find_prev_cmd(self, slot7, cmd)
		 20	[245]	TGETS	  6	5	7	; slot6 = cmd_default_increment.value
		 21	[245]	IST  	   		6	; if cmd_default_increment.value
		 22	[245]	JMP  	  7		1	; 	goto 24
		 23	[245]	KSHORT	  6		1	; slot6 = 1
		 24	[247]	UGET 	  7		0	; slot7 = uv0"tsv_value_col"
		 25	[247]	TGETV	  7	2	7	; slot7 = row[uv0"tsv_value_col"]
		 26	[248]	TGETS	  8	4	6	; slot8 = cmd_cols.time_columns
		 27	[248]	TGETS	  8	8	5	; slot8 = cmd_cols.time_columns.inc
		 28	[248]	TGETV	  8	2	8	; slot8 = row[cmd_cols.time_columns.inc]
		 29	[248]	IST  	   		8	; if slot8
		 30	[248]	JMP  	  9		1	; 	goto 32
		 31	[248]	MOV  	  8		6	; slot8 = default_increment
		 32	[249]	UGET 	  9		1	; slot9 = uv1"log"
		 33	[249]	TGETS	  9	9	4	; slot9 = uv1"log".debug
		 34	[249]	KSTR 	 10		3	; slot10 = "waiting for signal %s..."
		 35	[249]	MOV  	 11		7	; slot11 = signal_name
		 36	[249]	CALL 	  9	1	3	;  = uv1"log".debug(slot10, signal_name)
		 37	[251]	TSETS	  7	1	2	; cmd.signal_name = signal_name
		 38	[252]	GGET 	  9		0	; slot9 = _env["tonumber"]
		 39	[252]	MOV  	 10		8	; slot10 = increment
		 40	[252]	CALL 	  9	2	2	; slot9 = tonumber(increment)
		 41	[252]	TSETS	  9	1	1	; cmd.wait_time = tonumber
		 42	[253]	RET0 	  0		1	; return
	 86	[239]	TSETS	 14	5	117	; wave_db.parse_wait_signal = slot14
	 87	[258]	FNEW 	 14		114	; @./all/wave_db.lua:255-258: 4 args, 1 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	tsv_value_col
		;;;; variable info ;;;;
		  0-7:	self
		  0-7:	cmd
		  0-7:	row
		  0-7:	row_idx
		  2-7:	value
		;;;; instructions ;;;;
		  1	[256]	UGET 	  4		0	; slot4 = uv0"tsv_value_col"
		  2	[256]	TGETV	  4	2	4	; slot4 = row[uv0"tsv_value_col"]
		  3	[257]	GGET 	  5		0	; slot5 = _env["tonumber"]
		  4	[257]	MOV  	  6		4	; slot6 = value
		  5	[257]	CALL 	  5	2	2	; slot5 = tonumber(value)
		  6	[257]	TSETS	  5	1	1	; cmd.value = tonumber
		  7	[258]	RET0 	  0		1	; return
	 88	[255]	TSETS	 14	5	115	; wave_db.parse_number = slot14
	 89	[276]	FNEW 	 14		112	; @./all/wave_db.lua:260-276: 4 args, 1 upvalues, 11 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	tsv_value_col
		;;;; variable info ;;;;
		  0-48:	self
		  0-48:	cmd
		  0-48:	row
		  0-48:	row_idx
		  5-48:	cmd_cols
		  16-48:	wave_name
		  35-48:	ws
		;;;; instructions ;;;;
		  1	[261]	MOV  	  5		0	; slot5 = self
		  2	[261]	TGETS	  4	0	12	; slot4 = self.find_prev_cmd
		  3	[261]	KSTR 	  6		11	; slot6 = "column_names"
		  4	[261]	MOV  	  7		1	; slot7 = cmd
		  5	[261]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[262]	IST  	   		4	; if cmd_cols
		  7	[262]	JMP  	  5		7	; 	goto 15
		  8	[263]	KPRI 	  5		2	; slot5 = true
		  9	[263]	GGET 	  6		10	; slot6 = _env["string"]
		 10	[263]	TGETS	  6	6	9	; slot6 = string.format
		 11	[263]	KSTR 	  7		8	; slot7 = "%s cmd requires a path command before"
		 12	[263]	TGETS	  8	1	7	; slot8 = cmd.name
		 13	[263]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[263]	RETM 	  5		1	; return , ...MULTRES
		 15	[265]	UGET 	  5		0	; slot5 = uv0"tsv_value_col"
		 16	[265]	TGETV	  5	2	5	; slot5 = row[uv0"tsv_value_col"]
		 17	[266]	ISF  	   		5	; if not wave_name
		 18	[266]	JMP  	  6		6	; 	goto 25
		 19	[266]	GGET 	  6		10	; slot6 = _env["string"]
		 20	[266]	TGETS	  6	6	6	; slot6 = string.trim
		 21	[266]	MOV  	  7		5	; slot7 = wave_name
		 22	[266]	CALL 	  6	2	2	; slot6 = string.trim(wave_name)
		 23	[266]	ISNES	  6		5	; if string.trim ~= ""
		 24	[266]	JMP  	  6		7	; 	goto 32
		 25	[267]	KPRI 	  6		2	; slot6 = true
		 26	[267]	GGET 	  7		10	; slot7 = _env["string"]
		 27	[267]	TGETS	  7	7	9	; slot7 = string.format
		 28	[267]	KSTR 	  8		4	; slot8 = "%s cmd requires a value with the name of the manual_wave"
		 29	[267]	TGETS	  9	1	7	; slot9 = cmd.name
		 30	[267]	CALL 	  7	0	3	; MULTRES = string.format(slot8, cmd.name)
		 31	[267]	RETM 	  6		1	; return , ...MULTRES
		 32	[269]	MOV  	  7		0	; slot7 = self
		 33	[269]	TGETS	  6	0	3	; slot6 = self.get_wave_status
		 34	[269]	MOV  	  8		5	; slot8 = wave_name
		 35	[269]	CALL 	  6	2	3	; slot6 = self.get_wave_status(self, wave_name)
		 36	[270]	ISF  	   		6	; if not ws
		 37	[270]	JMP  	  7		7	; 	goto 45
		 38	[271]	KPRI 	  7		2	; slot7 = true
		 39	[271]	GGET 	  8		10	; slot8 = _env["string"]
		 40	[271]	TGETS	  8	8	9	; slot8 = string.format
		 41	[271]	KSTR 	  9		2	; slot9 = "manual waves must be unique. name: %s already exists"
		 42	[271]	MOV  	 10		5	; slot10 = wave_name
		 43	[271]	CALL 	  8	0	3	; MULTRES = string.format(slot9, wave_name)
		 44	[271]	RETM 	  7		1	; return , ...MULTRES
		 45	[274]	TSETS	  5	1	1	; cmd.wave_name = wave_name
		 46	[275]	KSHORT	  7		0	; slot7 = 0
		 47	[275]	TSETS	  7	1	0	; cmd.wait_time = slot7
		 48	[276]	RET0 	  0		1	; return
	 90	[260]	TSETS	 14	5	113	; wave_db.parse_manual_wave = slot14
	 91	[299]	FNEW 	 14		110	; @./all/wave_db.lua:278-299: 4 args, 1 upvalues, 12 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	tsv_value_col
		;;;; variable info ;;;;
		  0-57:	self
		  0-57:	cmd
		  0-57:	row
		  0-57:	row_idx
		  5-57:	cmd_cols
		  19-57:	cmd_mw
		  32-57:	mws
		  48-57:	value
		;;;; instructions ;;;;
		  1	[279]	MOV  	  5		0	; slot5 = self
		  2	[279]	TGETS	  4	0	13	; slot4 = self.find_prev_cmd
		  3	[279]	KSTR 	  6		12	; slot6 = "column_names"
		  4	[279]	MOV  	  7		1	; slot7 = cmd
		  5	[279]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[280]	IST  	   		4	; if cmd_cols
		  7	[280]	JMP  	  5		7	; 	goto 15
		  8	[281]	KPRI 	  5		2	; slot5 = true
		  9	[281]	GGET 	  6		11	; slot6 = _env["string"]
		 10	[281]	TGETS	  6	6	10	; slot6 = string.format
		 11	[281]	KSTR 	  7		9	; slot7 = "%s cmd requires a path command before"
		 12	[281]	TGETS	  8	1	8	; slot8 = cmd.name
		 13	[281]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[281]	RETM 	  5		1	; return , ...MULTRES
		 15	[283]	MOV  	  6		0	; slot6 = self
		 16	[283]	TGETS	  5	0	13	; slot5 = self.find_prev_cmd
		 17	[283]	KSTR 	  7		7	; slot7 = "manual_wave"
		 18	[283]	MOV  	  8		1	; slot8 = cmd
		 19	[283]	CALL 	  5	2	4	; slot5 = self.find_prev_cmd(self, slot7, cmd)
		 20	[284]	IST  	   		5	; if cmd_mw
		 21	[284]	JMP  	  6		7	; 	goto 29
		 22	[285]	KPRI 	  6		2	; slot6 = true
		 23	[285]	GGET 	  7		11	; slot7 = _env["string"]
		 24	[285]	TGETS	  7	7	10	; slot7 = string.format
		 25	[285]	KSTR 	  8		6	; slot8 = "%s cmd requires a manual command before"
		 26	[285]	TGETS	  9	1	8	; slot9 = cmd.name
		 27	[285]	CALL 	  7	0	3	; MULTRES = string.format(slot8, cmd.name)
		 28	[285]	RETM 	  6		1	; return , ...MULTRES
		 29	[287]	MOV  	  7		0	; slot7 = self
		 30	[287]	TGETS	  6	0	5	; slot6 = self.get_wave_status
		 31	[287]	TGETS	  8	5	4	; slot8 = cmd_mw.wave_name
		 32	[287]	CALL 	  6	2	3	; slot6 = self.get_wave_status(self, cmd_mw.wave_name)
		 33	[288]	IST  	   		6	; if mws
		 34	[288]	JMP  	  7		8	; 	goto 43
		 35	[289]	KPRI 	  7		2	; slot7 = true
		 36	[289]	GGET 	  8		11	; slot8 = _env["string"]
		 37	[289]	TGETS	  8	8	10	; slot8 = string.format
		 38	[289]	KSTR 	  9		3	; slot9 = "%s cmd requires manual_wave %s before"
		 39	[289]	TGETS	 10	1	8	; slot10 = cmd.name
		 40	[289]	TGETS	 11	5	4	; slot11 = cmd_mw.wave_name
		 41	[289]	CALL 	  8	0	4	; MULTRES = string.format(slot9, cmd.name, cmd_mw.wave_name)
		 42	[289]	RETM 	  7		1	; return , ...MULTRES
		 43	[292]	TGETS	  7	5	4	; slot7 = cmd_mw.wave_name
		 44	[292]	TSETS	  7	1	4	; cmd.wave_name = cmd_mw.wave_name
		 45	[293]	GGET 	  7		2	; slot7 = _env["tonumber"]
		 46	[293]	UGET 	  8		0	; slot8 = uv0"tsv_value_col"
		 47	[293]	TGETV	  8	2	8	; slot8 = row[uv0"tsv_value_col"]
		 48	[293]	CALL 	  7	2	2	; slot7 = tonumber(slot8)
		 49	[294]	ISTC 	  8		7	; slot8 = value; if value
		 50	[294]	JMP  	  8		1	; 	goto 52
		 51	[294]	KSHORT	  8		0	; slot8 = 0
		 52	[294]	TSETS	  8	1	1	; cmd.repeat_count = slot8
		 53	[297]	TGETS	  8	1	1	; slot8 = cmd.repeat_count
		 54	[297]	TSETS	  8	6	1	; mws.repeat_count = cmd.repeat_count
		 55	[298]	TGETS	  8	1	1	; slot8 = cmd.repeat_count
		 56	[298]	TSETS	  8	6	0	; mws.repeat_remaining = cmd.repeat_count
		 57	[299]	RET0 	  0		1	; return
	 92	[278]	TSETS	 14	5	111	; wave_db.parse_manual_wave_repeat = slot14
	 93	[314]	FNEW 	 14		108	; @./all/wave_db.lua:301-314: 4 args, 0 upvalues, 10 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-35:	self
		  0-35:	cmd
		  0-35:	row
		  0-35:	row_idx
		  5-35:	cmd_cols
		  19-35:	cmd_default_increment
		  25-35:	default_increment
		  26-35:	tc
		  30-35:	row_increment
		;;;; instructions ;;;;
		  1	[302]	MOV  	  5		0	; slot5 = self
		  2	[302]	TGETS	  4	0	11	; slot4 = self.find_prev_cmd
		  3	[302]	KSTR 	  6		10	; slot6 = "column_names"
		  4	[302]	MOV  	  7		1	; slot7 = cmd
		  5	[302]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, cmd)
		  6	[303]	IST  	   		4	; if cmd_cols
		  7	[303]	JMP  	  5		7	; 	goto 15
		  8	[304]	KPRI 	  5		2	; slot5 = true
		  9	[304]	GGET 	  6		9	; slot6 = _env["string"]
		 10	[304]	TGETS	  6	6	8	; slot6 = string.format
		 11	[304]	KSTR 	  7		7	; slot7 = "%s cmd requires a path command before"
		 12	[304]	TGETS	  8	1	6	; slot8 = cmd.name
		 13	[304]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cmd.name)
		 14	[304]	RETM 	  5		1	; return , ...MULTRES
		 15	[308]	MOV  	  6		0	; slot6 = self
		 16	[308]	TGETS	  5	0	11	; slot5 = self.find_prev_cmd
		 17	[308]	KSTR 	  7		5	; slot7 = "default_increment"
		 18	[308]	MOV  	  8		1	; slot8 = cmd
		 19	[308]	CALL 	  5	2	4	; slot5 = self.find_prev_cmd(self, slot7, cmd)
		 20	[309]	ISF  	   		5	; if not cmd_default_increment
		 21	[309]	JMP  	  6		3	; 	goto 25
		 22	[309]	TGETS	  6	5	4	; slot6 = cmd_default_increment.value
		 23	[309]	IST  	   		6	; if cmd_default_increment.value
		 24	[309]	JMP  	  7		1	; 	goto 26
		 25	[309]	KSHORT	  6		1	; slot6 = 1
		 26	[310]	TGETS	  7	4	3	; slot7 = cmd_cols.time_columns
		 27	[311]	GGET 	  8		2	; slot8 = _env["tonumber"]
		 28	[311]	TGETS	  9	7	1	; slot9 = tc.inc
		 29	[311]	TGETV	  9	2	9	; slot9 = row[tc.inc]
		 30	[311]	CALL 	  8	2	2	; slot8 = tonumber(slot9)
		 31	[313]	ISTC 	  9		8	; slot9 = row_increment; if row_increment
		 32	[313]	JMP  	  9		1	; 	goto 34
		 33	[313]	MOV  	  9		6	; slot9 = default_increment
		 34	[313]	TSETS	  9	1	0	; cmd.wait_time = default_increment
		 35	[314]	RET0 	  0		1	; return
	 94	[301]	TSETS	 14	5	109	; wave_db.parse_wait = slot14
	 95	[317]	TDUP 	 14		106	; slot14 = copy table#k106
	 96	[318]	TNEW 	 15		0	; slot15 = new table( array: 0, dict: 1)
	 97	[318]	TSETS	 15	14	105	; slot14.# = slot15
	 98	[319]	TNEW 	 15		0	; slot15 = new table( array: 0, dict: 1)
	 99	[319]	TSETS	 15	14	104	; slot14.sheet_name = slot15
	100	[320]	TNEW 	 15		0	; slot15 = new table( array: 0, dict: 1)
	101	[320]	TSETS	 15	14	103	; slot14.description = slot15
	102	[321]	TDUP 	 15		102	; slot15 = copy table#k102
	103	[321]	TGETS	 16	5	115	; slot16 = wave_db.parse_number
	104	[321]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_number
	105	[321]	TSETS	 15	14	100	; slot14.lives = slot15
	106	[322]	TDUP 	 15		99	; slot15 = copy table#k99
	107	[322]	TGETS	 16	5	115	; slot16 = wave_db.parse_number
	108	[322]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_number
	109	[322]	TSETS	 15	14	98	; slot14.gold = slot15
	110	[323]	TDUP 	 15		97	; slot15 = copy table#k97
	111	[323]	TGETS	 16	5	115	; slot16 = wave_db.parse_number
	112	[323]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_number
	113	[323]	TSETS	 15	14	96	; slot14.gems = slot15
	114	[324]	TDUP 	 15		95	; slot15 = copy table#k95
	115	[324]	TGETS	 16	5	115	; slot16 = wave_db.parse_number
	116	[324]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_number
	117	[324]	TSETS	 15	14	94	; slot14.gem_keepers = slot15
	118	[325]	TNEW 	 15		0	; slot15 = new table( array: 0, dict: 1)
	119	[325]	TSETS	 15	14	93	; slot14.enemy_prefix = slot15
	120	[326]	TDUP 	 15		92	; slot15 = copy table#k92
	121	[326]	TGETS	 16	5	115	; slot16 = wave_db.parse_number
	122	[326]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_number
	123	[326]	TSETS	 15	14	91	; slot14.default_increment = slot15
	124	[327]	TDUP 	 15		90	; slot15 = copy table#k90
	125	[327]	TGETS	 16	5	115	; slot16 = wave_db.parse_number
	126	[327]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_number
	127	[327]	TSETS	 15	14	89	; slot14.default_interval = slot15
	128	[328]	TDUP 	 15		88	; slot15 = copy table#k88
	129	[328]	TGETS	 16	5	115	; slot16 = wave_db.parse_number
	130	[328]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_number
	131	[328]	TSETS	 15	14	87	; slot14.interval = slot15
	132	[329]	TDUP 	 15		86	; slot15 = copy table#k86
	133	[329]	TGETS	 16	5	129	; slot16 = wave_db.parse_column_names
	134	[329]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_column_names
	135	[329]	TSETS	 15	14	85	; slot14.column_names = slot15
	136	[330]	TDUP 	 15		84	; slot15 = copy table#k84
	137	[330]	TGETS	 16	5	127	; slot16 = wave_db.parse_flags
	138	[330]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_flags
	139	[330]	TSETS	 15	14	83	; slot14.flags = slot15
	140	[331]	TDUP 	 15		82	; slot15 = copy table#k82
	141	[331]	TGETS	 16	5	125	; slot16 = wave_db.parse_wave
	142	[331]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_wave
	143	[331]	TSETS	 15	14	81	; slot14.wave = slot15
	144	[332]	TDUP 	 15		80	; slot15 = copy table#k80
	145	[332]	TGETS	 16	5	123	; slot16 = wave_db.parse_spawn
	146	[332]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_spawn
	147	[332]	TSETS	 15	14	79	; slot14.spawn = slot15
	148	[333]	TDUP 	 15		78	; slot15 = copy table#k78
	149	[333]	TGETS	 16	5	109	; slot16 = wave_db.parse_wait
	150	[333]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_wait
	151	[333]	TSETS	 15	14	77	; slot14.wait = slot15
	152	[334]	TDUP 	 15		76	; slot15 = copy table#k76
	153	[334]	TGETS	 16	5	121	; slot16 = wave_db.parse_event
	154	[334]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_event
	155	[334]	TSETS	 15	14	75	; slot14.event = slot15
	156	[335]	TDUP 	 15		74	; slot15 = copy table#k74
	157	[335]	TGETS	 16	5	119	; slot16 = wave_db.parse_signal
	158	[335]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_signal
	159	[335]	TSETS	 15	14	73	; slot14.signal = slot15
	160	[336]	TDUP 	 15		72	; slot15 = copy table#k72
	161	[336]	TGETS	 16	5	117	; slot16 = wave_db.parse_wait_signal
	162	[336]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_wait_signal
	163	[336]	TSETS	 15	14	71	; slot14.wait_signal = slot15
	164	[337]	TDUP 	 15		70	; slot15 = copy table#k70
	165	[337]	TGETS	 16	5	113	; slot16 = wave_db.parse_manual_wave
	166	[337]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_manual_wave
	167	[337]	TSETS	 15	14	69	; slot14.manual_wave = slot15
	168	[338]	TDUP 	 15		68	; slot15 = copy table#k68
	169	[338]	TGETS	 16	5	111	; slot16 = wave_db.parse_manual_wave_repeat
	170	[338]	TSETS	 16	15	101	; slot15.parse_fn = wave_db.parse_manual_wave_repeat
	171	[338]	TSETS	 15	14	67	; slot14.manual_wave_repeat = slot15
	172	[339]	TNEW 	 15		0	; slot15 = new table( array: 0, dict: 1)
	173	[339]	TSETS	 15	14	66	; slot14.call_manual_wave = slot15
	174	[340]	TSETS	 14	5	107	; wave_db.tsv_cmds = slot14
	175	[412]	FNEW 	 14		64	; @./all/wave_db.lua:344-412: 2 args, 3 upvalues, 24 slots
		
		;;;; constant tables ;;;;
		ktable#16 = [
			[max_same] = 0,
			[interval_next] = 0,
			[max] = 1,
			]
		
		
		ktable#35 = [
			]
		
		
		;;;; upvalue names ;;;;
		  0:	log_e
		  1:	E
		  2:	log
		;;;; variable info ;;;;
		  0-148:	self
		  0-148:	wave_cmd
		  5-148:	path_columns
		  22-148:	group
		  23-148:	out
		  24-148:	w
		  25-148:	delay
		  26-148:	has_flying
		  30-148:	wave_idx
		  34-134:	<index>
		  34-134:	<limit>
		  34-134:	<step>
		  35-133:	i
		  37-133:	cmd
		  49-133:	interval
		  53-120:	<generator>
		  53-120:	<state>
		  53-120:	<control>
		  54-118:	_
		  54-118:	es
		  107-118:	tpl
		;;;; instructions ;;;;
		  1	[345]	MOV  	  3		0	; slot3 = self
		  2	[345]	TGETS	  2	0	39	; slot2 = self.find_prev_cmd
		  3	[345]	KSTR 	  4		38	; slot4 = "column_names"
		  4	[345]	MOV  	  5		1	; slot5 = wave_cmd
		  5	[345]	CALL 	  2	2	4	; slot2 = self.find_prev_cmd(self, slot4, wave_cmd)
		  6	[346]	IST  	   		2	; if path_columns
		  7	[346]	JMP  	  3		5	; 	goto 13
		  8	[347]	UGET 	  3		0	; slot3 = uv0"log_e"
		  9	[347]	KSTR 	  4		37	; slot4 = "%s cmd requires a path command before"
		 10	[347]	TGETS	  5	1	36	; slot5 = wave_cmd.name
		 11	[347]	CALL 	  3	1	3	;  = uv0"log_e"(slot4, wave_cmd.name)
		 12	[348]	RET0 	  0		1	; return
		 13	[351]	TDUP 	  3		35	; slot3 = copy table#k35
		 14	[352]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
		 15	[352]	TSETS	  4	3	34	; slot3.waves = slot4
		 16	[353]	TGETS	  4	1	33	; slot4 = wave_cmd.wait_time
		 17	[353]	IST  	   		4	; if wave_cmd.wait_time
		 18	[353]	JMP  	  5		1	; 	goto 20
		 19	[353]	KSHORT	  4		0	; slot4 = 0
		 20	[353]	GGET 	  5		32	; slot5 = _env["FPS"]
		 21	[353]	MULVV	  4	4	5	; slot4 = slot4 * FPS
		 22	[353]	TSETS	  4	3	31	; slot3.interval = slot4
		 23	[356]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
		 24	[357]	KPRI 	  5		0	; slot5 = nil
		 25	[358]	KSHORT	  6		0	; slot6 = 0
		 26	[359]	KPRI 	  7		1	; slot7 = false
		 27	[361]	MOV  	  9		0	; slot9 = self
		 28	[361]	TGETS	  8	0	30	; slot8 = self.get_cmd_idx
		 29	[361]	MOV  	 10		1	; slot10 = wave_cmd
		 30	[361]	CALL 	  8	2	3	; slot8 = self.get_cmd_idx(self, wave_cmd)
		 31	[362]	ADDVN	  9	8	0	; slot9 = wave_idx + 1
		 32	[362]	TGETS	 10	0	29	; slot10 = self.db_cmds
		 33	[362]	LEN  	 10		10	; slot10 = #self.db_cmds
		 34	[362]	KSHORT	 11		1	; slot11 = 1
		 35	[362]	FORI 	  9		99	; for slot12 = slot9,slot10,slot11 else goto 135
		 36	[363]	TGETS	 13	0	29	; slot13 = self.db_cmds
		 37	[363]	TGETV	 13	13	12	; slot13 = self.db_cmds[i]
		 38	[364]	TGETS	 14	13	36	; slot14 = cmd.name
		 39	[364]	ISEQS	 14		28	; if cmd.name == "wave"
		 40	[364]	JMP  	 14		94	; 	goto 135
		 41	[364]	TGETS	 14	13	36	; slot14 = cmd.name
		 42	[364]	ISNES	 14		27	; if cmd.name ~= "manual_wave"
		 43	[364]	JMP  	 14		2	; 	goto 46
		 44	[365]	JMP  	  9		90	; 	goto 135
		 45	[365]	JMP  	 14		88	; 	goto 134
		 46	[366]	TGETS	 14	13	36	; slot14 = cmd.name
		 47	[366]	ISNES	 14		26	; if cmd.name ~= "spawn"
		 48	[366]	JMP  	 14		85	; 	goto 134
		 49	[367]	TGETS	 14	13	33	; slot14 = cmd.wait_time
		 50	[368]	ADDVV	  6	6	14	; slot6 = delay + interval
		 51	[369]	GGET 	 15		25	; slot15 = _env["pairs"]
		 52	[369]	TGETS	 16	13	24	; slot16 = cmd.spawns
		 53	[369]	CALL 	 15	4	2	; slot15, slot16, slot17 = pairs(cmd.spawns)
		 54	[369]	ISNEXT	 18		64	; Verify ITERN at 119; goto 119
		 55	[370]	ISF  	   		5	; if not w
		 56	[370]	JMP  	 20		15	; 	goto 72
		 57	[370]	TGETS	 20	5	23	; slot20 = w.path_index
		 58	[370]	TGETS	 21	19	22	; slot21 = es.pi
		 59	[370]	ISEQV	 20		21	; if w.path_index == es.pi
		 60	[370]	JMP  	 20		11	; 	goto 72
		 61	[372]	GGET 	 20		32	; slot20 = _env["FPS"]
		 62	[372]	MULVV	 20	6	20	; slot20 = delay * FPS
		 63	[372]	TSETS	 20	5	21	; w.delay = slot20
		 64	[373]	TSETS	  7	5	20	; w.some_flying = has_flying
		 65	[374]	GGET 	 20		19	; slot20 = _env["table"]
		 66	[374]	TGETS	 20	20	18	; slot20 = table.insert
		 67	[374]	TGETS	 21	3	34	; slot21 = group.waves
		 68	[374]	MOV  	 22		5	; slot22 = w
		 69	[374]	CALL 	 20	1	3	;  = table.insert(group.waves, w)
		 70	[375]	KPRI 	  5		0	; slot5 = nil
		 71	[376]	KPRI 	  7		1	; slot7 = false
		 72	[378]	IST  	   		5	; if w
		 73	[378]	JMP  	 20		5	; 	goto 79
		 74	[379]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		 75	[380]	TGETS	 20	19	22	; slot20 = es.pi
		 76	[380]	TSETS	 20	5	23	; w.path_index = es.pi
		 77	[381]	TNEW 	 20		0	; slot20 = new table( array: 0, dict: 1)
		 78	[381]	TSETS	 20	5	24	; w.spawns = slot20
		 79	[383]	GGET 	 20		19	; slot20 = _env["table"]
		 80	[383]	TGETS	 20	20	18	; slot20 = table.insert
		 81	[383]	TGETS	 21	5	24	; slot21 = w.spawns
		 82	[383]	TDUP 	 22		16	; slot22 = copy table#k16
		 83	[383]	TGETS	 23	19	17	; slot23 = es.enemy
		 84	[383]	TSETS	 23	22	15	; slot22.creep = es.enemy
		 85	[384]	TGETS	 23	19	14	; slot23 = es.spi
		 86	[384]	ISNES	 23		13	; if es.spi ~= "*"
		 87	[384]	JMP  	 23		2	; 	goto 90
		 88	[384]	KSHORT	 23		0	; slot23 = 0
		 89	[384]	JMP  	 24		1	; 	goto 91
		 90	[384]	KSHORT	 23		1	; slot23 = 1
		 91	[384]	TSETS	 23	22	12	; slot22.fixed_sub_path = slot23
		 92	[385]	GGET 	 23		32	; slot23 = _env["FPS"]
		 93	[385]	MULVV	 23	14	23	; slot23 = interval * FPS
		 94	[385]	TSETS	 23	22	31	; slot22.interval = slot23
		 95	[389]	TGETS	 23	19	14	; slot23 = es.spi
		 96	[389]	ISNES	 23		13	; if es.spi ~= "*"
		 97	[389]	JMP  	 23		2	; 	goto 100
		 98	[389]	KSHORT	 23		1	; slot23 = 1
		 99	[389]	JMP  	 24		1	; 	goto 101
		100	[389]	TGETS	 23	19	14	; slot23 = es.spi
		101	[389]	TSETS	 23	22	11	; slot22.path = es.spi
		102	[383]	CALL 	 20	1	3	;  = table.insert(w.spawns, slot22)
		103	[390]	UGET 	 20		1	; slot20 = uv1"E"
		104	[390]	MOV  	 21		20	; slot21 = uv1"E"
		105	[390]	TGETS	 20	20	10	; slot20 = uv1"E".get_template
		106	[390]	TGETS	 22	19	17	; slot22 = es.enemy
		107	[390]	CALL 	 20	2	3	; slot20 = uv1"E".get_template(uv1"E", es.enemy)
		108	[391]	ISF  	   		20	; if not tpl
		109	[391]	JMP  	 21		9	; 	goto 119
		110	[391]	GGET 	 21		9	; slot21 = _env["bit"]
		111	[391]	TGETS	 21	21	8	; slot21 = bit.band
		112	[391]	TGETS	 22	20	7	; slot22 = tpl.vis
		113	[391]	TGETS	 22	22	6	; slot22 = tpl.vis.flags
		114	[391]	GGET 	 23		5	; slot23 = _env["F_FLYING"]
		115	[391]	CALL 	 21	2	3	; slot21 = bit.band(tpl.vis.flags, F_FLYING)
		116	[391]	ISEQN	 21		1	; if bit.band == 0
		117	[391]	JMP  	 21		1	; 	goto 119
		118	[392]	KPRI 	  7		2	; slot7 = true
		119	[369]	ITERN	 18	3	3	; slot18, slot19, slot20 = slot15<generator>, slot16<state>, slot17<control>; slot18, slot19 = slot15<generator>(slot16<state>, slot17<control>)
		120	[369]	ITERL	 18		-66	; slot17<control> = slot18; if slot18 != nil goto 55
		121	[397]	ISF  	   		5	; if not w
		122	[397]	JMP  	 15		11	; 	goto 134
		123	[398]	GGET 	 15		32	; slot15 = _env["FPS"]
		124	[398]	MULVV	 15	6	15	; slot15 = delay * FPS
		125	[398]	TSETS	 15	5	21	; w.delay = slot15
		126	[399]	TSETS	  7	5	20	; w.some_flying = has_flying
		127	[400]	GGET 	 15		19	; slot15 = _env["table"]
		128	[400]	TGETS	 15	15	18	; slot15 = table.insert
		129	[400]	TGETS	 16	3	34	; slot16 = group.waves
		130	[400]	MOV  	 17		5	; slot17 = w
		131	[400]	CALL 	 15	1	3	;  = table.insert(group.waves, w)
		132	[401]	KPRI 	  5		0	; slot5 = nil
		133	[402]	KPRI 	  7		1	; slot7 = false
		134	[362]	FORL 	  9		-99	; slot12 = slot12 + slot11<step>; if cmp(slot12, sign slot11<step>,  slot10<limit>) goto 36
		135	[407]	UGET 	  9		2	; slot9 = uv2"log"
		136	[407]	TGETS	  9	9	4	; slot9 = uv2"log".level
		137	[407]	UGET 	 10		2	; slot10 = uv2"log"
		138	[407]	TGETS	 10	10	3	; slot10 = uv2"log".PARANOID_LEVEL
		139	[407]	ISNEV	  9		10	; if uv2"log".level ~= uv2"log".PARANOID_LEVEL
		140	[407]	JMP  	  9		7	; 	goto 148
		141	[408]	UGET 	  9		2	; slot9 = uv2"log"
		142	[408]	TGETS	  9	9	2	; slot9 = uv2"log".paranoid
		143	[408]	KSTR 	 10		1	; slot10 = "group:%s"
		144	[408]	GGET 	 11		0	; slot11 = _env["getfulldump"]
		145	[408]	MOV  	 12		3	; slot12 = group
		146	[408]	CALL 	 11	0	2	; MULTRES = getfulldump(group)
		147	[408]	CALLM	  9	1	1	;  = uv2"log".paranoid(slot10, ...MULTRES)
		148	[411]	RET1 	  3		2	; return group
	176	[344]	TSETS	 14	5	65	; wave_db.create_wave_group_from_tsv = slot14
	177	[446]	FNEW 	 14		62	; @./all/wave_db.lua:414-446: 2 args, 1 upvalues, 13 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-47:	self
		  0-47:	idx
		  1-47:	wave_count
		  2-47:	start_idx
		  5-16:	<generator>
		  5-16:	<state>
		  5-16:	<control>
		  6-14:	i
		  6-14:	cmd
		  25-47:	spawns
		  29-46:	<index>
		  29-46:	<limit>
		  29-46:	<step>
		  30-45:	i
		  32-45:	cmd
		;;;; instructions ;;;;
		  1	[416]	KSHORT	  2		0	; slot2 = 0
		  2	[417]	KPRI 	  3		0	; slot3 = nil
		  3	[419]	GGET 	  4		9	; slot4 = _env["pairs"]
		  4	[419]	TGETS	  5	0	8	; slot5 = self.db_cmds
		  5	[419]	CALL 	  4	4	2	; slot4, slot5, slot6 = pairs(self.db_cmds)
		  6	[419]	ISNEXT	  7		8	; Verify ITERN at 15; goto 15
		  7	[420]	TGETS	  9	8	7	; slot9 = cmd.name
		  8	[420]	ISNES	  9		6	; if cmd.name ~= "wave"
		  9	[420]	JMP  	  9		5	; 	goto 15
		 10	[421]	ADDVN	  2	2	0	; slot2 = wave_count + 1
		 11	[422]	ISNEV	  2		1	; if wave_count ~= idx
		 12	[422]	JMP  	  9		2	; 	goto 15
		 13	[424]	MOV  	  3		7	; slot3 = i
		 14	[425]	JMP  	  4		2	; 	goto 17
		 15	[419]	ITERN	  7	3	3	; slot7, slot8, slot9 = slot4<generator>, slot5<state>, slot6<control>; slot7, slot8 = slot4<generator>(slot5<state>, slot6<control>)
		 16	[419]	ITERL	  7		-10	; slot6<control> = slot7; if slot7 != nil goto 7
		 17	[429]	IST  	   		3	; if start_idx
		 18	[429]	JMP  	  4		6	; 	goto 25
		 19	[430]	UGET 	  4		0	; slot4 = uv0"log"
		 20	[430]	TGETS	  4	4	5	; slot4 = uv0"log".paranoid
		 21	[430]	KSTR 	  5		4	; slot5 = "wave %s not found"
		 22	[430]	MOV  	  6		1	; slot6 = idx
		 23	[430]	CALL 	  4	1	3	;  = uv0"log".paranoid(slot5, idx)
		 24	[431]	RET0 	  0		1	; return
		 25	[434]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
		 26	[435]	ADDVN	  5	3	0	; slot5 = start_idx + 1
		 27	[435]	TGETS	  6	0	8	; slot6 = self.db_cmds
		 28	[435]	LEN  	  6		6	; slot6 = #self.db_cmds
		 29	[435]	KSHORT	  7		1	; slot7 = 1
		 30	[435]	FORI 	  5		16	; for slot8 = slot5,slot6,slot7 else goto 47
		 31	[436]	TGETS	  9	0	8	; slot9 = self.db_cmds
		 32	[436]	TGETV	  9	9	8	; slot9 = self.db_cmds[i]
		 33	[437]	TGETS	 10	9	7	; slot10 = cmd.name
		 34	[437]	ISNES	 10		6	; if cmd.name ~= "wave"
		 35	[437]	JMP  	 10		2	; 	goto 38
		 36	[439]	RET1 	  4		2	; return spawns
		 37	[439]	JMP  	 10		8	; 	goto 46
		 38	[440]	TGETS	 10	9	7	; slot10 = cmd.name
		 39	[440]	ISNES	 10		3	; if cmd.name ~= "spawn"
		 40	[440]	JMP  	 10		5	; 	goto 46
		 41	[441]	GGET 	 10		2	; slot10 = _env["table"]
		 42	[441]	TGETS	 10	10	1	; slot10 = table.append
		 43	[441]	MOV  	 11		4	; slot11 = spawns
		 44	[441]	TGETS	 12	9	0	; slot12 = cmd.spawns
		 45	[441]	CALL 	 10	1	3	;  = table.append(spawns, cmd.spawns)
		 46	[435]	FORL 	  5		-16	; slot8 = slot8 + slot7<step>; if cmp(slot8, sign slot7<step>,  slot6<limit>) goto 31
		 47	[445]	RET1 	  4		2	; return spawns
	178	[414]	TSETS	 14	5	63	; wave_db.get_spawns_for_wave = slot14
	179	[514]	FNEW 	 14		60	; @./all/wave_db.lua:449-514: 3 args, 3 upvalues, 17 slots
		
		;;;; constant tables ;;;;
		ktable#18 = [
			[name] = #,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	log
		  1:	tsv_cmd_col
		  2:	tsv_value_col
		;;;; variable info ;;;;
		  0-126:	self
		  0-126:	row
		  0-126:	row_idx
		  10-39:	<generator>
		  10-39:	<state>
		  10-39:	<control>
		  11-37:	_
		  11-37:	col
		  40-126:	cname
		  48-126:	path_cmd
		  55-82:	pc
		  58-82:	<generator>
		  58-82:	<state>
		  58-82:	<control>
		  59-80:	pi
		  62-80:	<generator>
		  62-80:	<state>
		  62-80:	<control>
		  63-78:	spi
		  63-78:	col_index
		  104-126:	parse_fn
		  105-126:	cmd
		  116-121:	err
		  116-121:	msg
		;;;; instructions ;;;;
		  1	[450]	UGET 	  3		0	; slot3 = uv0"log"
		  2	[450]	TGETS	  3	3	28	; slot3 = uv0"log".paranoid
		  3	[450]	KSTR 	  4		27	; slot4 = "-- row: | %s | %s | %s |"
		  4	[450]	TGETB	  5	1	1	; slot5 = row[1]
		  5	[450]	TGETB	  6	1	2	; slot6 = row[2]
		  6	[450]	TGETB	  7	1	3	; slot7 = row[3]
		  7	[450]	CALL 	  3	1	5	;  = uv0"log".paranoid(slot4, slot5, slot6, slot7)
		  8	[453]	GGET 	  3		26	; slot3 = _env["ipairs"]
		  9	[453]	MOV  	  4		1	; slot4 = row
		 10	[453]	CALL 	  3	4	2	; slot3, slot4, slot5 = ipairs(row)
		 11	[453]	JMP  	  6		26	; 	goto 38
		 12	[454]	GGET 	  8		25	; slot8 = _env["string"]
		 13	[454]	TGETS	  8	8	24	; slot8 = string.starts
		 14	[454]	MOV  	  9		7	; slot9 = col
		 15	[454]	KSTR 	 10		23	; slot10 = "#"
		 16	[454]	CALL 	  8	2	3	; slot8 = string.starts(col, slot10)
		 17	[454]	ISF  	   		8	; if not string.starts
		 18	[454]	JMP  	  9		12	; 	goto 31
		 19	[456]	UGET 	  8		0	; slot8 = uv0"log"
		 20	[456]	TGETS	  8	8	28	; slot8 = uv0"log".paranoid
		 21	[456]	KSTR 	  9		22	; slot9 = "comment found. skipping row %s"
		 22	[456]	GGET 	 10		21	; slot10 = _env["table"]
		 23	[456]	TGETS	 10	10	20	; slot10 = table.concat
		 24	[456]	MOV  	 11		1	; slot11 = row
		 25	[456]	KSTR 	 12		19	; slot12 = " "
		 26	[456]	CALL 	 10	0	3	; MULTRES = table.concat(row, slot12)
		 27	[456]	CALLM	  8	1	1	;  = uv0"log".paranoid(slot9, ...MULTRES)
		 28	[457]	TDUP 	  8		18	; slot8 = copy table#k18
		 29	[457]	RET1 	  8		2	; return slot8
		 30	[457]	JMP  	  8		7	; 	goto 38
		 31	[458]	GGET 	  8		25	; slot8 = _env["string"]
		 32	[458]	TGETS	  8	8	17	; slot8 = string.trim
		 33	[458]	MOV  	  9		7	; slot9 = col
		 34	[458]	CALL 	  8	2	2	; slot8 = string.trim(col)
		 35	[458]	ISEQS	  8		16	; if string.trim == ""
		 36	[458]	JMP  	  8		1	; 	goto 38
		 37	[460]	JMP  	  3		2	; 	goto 40
		 38	[453]	ITERC	  6	3	3	; slot6, slot7, slot8 = slot3<generator>, slot4<state>, slot5<control>; slot6, slot7 = slot3<generator>(slot4<state>, slot5<control>)
		 39	[453]	ITERL	  6		-28	; slot5<control> = slot6; if slot6 != nil goto 12
		 40	[464]	KPRI 	  3		0	; slot3 = nil
		 41	[467]	MOV  	  5		0	; slot5 = self
		 42	[467]	TGETS	  4	0	15	; slot4 = self.find_prev_cmd
		 43	[467]	KSTR 	  6		14	; slot6 = "column_names"
		 44	[467]	TGETS	  7	0	13	; slot7 = self.db_cmds
		 45	[467]	TGETS	  8	0	13	; slot8 = self.db_cmds
		 46	[467]	LEN  	  8		8	; slot8 = #self.db_cmds
		 47	[467]	TGETV	  7	7	8	; slot7 = self.db_cmds[slot8]
		 48	[467]	CALL 	  4	2	4	; slot4 = self.find_prev_cmd(self, slot6, slot7)
		 49	[468]	ISF  	   		4	; if not path_cmd
		 50	[468]	JMP  	  5		32	; 	goto 83
		 51	[468]	UGET 	  5		1	; slot5 = uv1"tsv_cmd_col"
		 52	[468]	TGETV	  5	1	5	; slot5 = row[uv1"tsv_cmd_col"]
		 53	[468]	ISNES	  5		16	; if slot5 ~= ""
		 54	[468]	JMP  	  5		28	; 	goto 83
		 55	[470]	TGETS	  5	4	12	; slot5 = path_cmd.path_columns
		 56	[471]	GGET 	  6		11	; slot6 = _env["pairs"]
		 57	[471]	MOV  	  7		5	; slot7 = pc
		 58	[471]	CALL 	  6	4	2	; slot6, slot7, slot8 = pairs(pc)
		 59	[471]	ISNEXT	  9		21	; Verify ITERN at 81; goto 81
		 60	[472]	GGET 	 10		11	; slot10 = _env["pairs"]
		 61	[472]	TGETV	 11	5	9	; slot11 = pc[pi]
		 62	[472]	CALL 	 10	4	2	; slot10, slot11, slot12 = pairs(slot11)
		 63	[472]	ISNEXT	 13		15	; Verify ITERN at 79; goto 79
		 64	[475]	TGETV	 15	1	14	; slot15 = row[col_index]
		 65	[475]	ISF  	   		15	; if not slot15
		 66	[475]	JMP  	 16		12	; 	goto 79
		 67	[475]	TGETV	 15	1	14	; slot15 = row[col_index]
		 68	[475]	ISEQS	 15		16	; if slot15 == ""
		 69	[475]	JMP  	 15		9	; 	goto 79
		 70	[475]	TGETV	 15	1	14	; slot15 = row[col_index]
		 71	[475]	ISEQS	 15		10	; if slot15 == ""
		 72	[475]	JMP  	 15		6	; 	goto 79
		 73	[476]	UGET 	 15		0	; slot15 = uv0"log"
		 74	[476]	TGETS	 15	15	28	; slot15 = uv0"log".paranoid
		 75	[476]	KSTR 	 16		9	; slot16 = "spawn found."
		 76	[476]	CALL 	 15	1	2	;  = uv0"log".paranoid(slot16)
		 77	[477]	KSTR 	  3		8	; slot3 = "spawn"
		 78	[478]	JMP  	  5		6	; 	goto 85
		 79	[472]	ITERN	 13	3	3	; slot13, slot14, slot15 = slot10<generator>, slot11<state>, slot12<control>; slot13, slot14 = slot10<generator>(slot11<state>, slot12<control>)
		 80	[472]	ITERL	 13		-17	; slot12<control> = slot13; if slot13 != nil goto 64
		 81	[471]	ITERN	  9	2	3	; slot9, slot10, slot11 = slot6<generator>, slot7<state>, slot8<control>; slot9 = slot6<generator>(slot7<state>, slot8<control>)
		 82	[471]	ITERL	  9		-23	; slot8<control> = slot9; if slot9 != nil goto 60
		 83	[485]	UGET 	  5		1	; slot5 = uv1"tsv_cmd_col"
		 84	[485]	TGETV	  3	1	5	; slot3 = row[uv1"tsv_cmd_col"]
		 85	[488]	ISF  	   		3	; if not cname
		 86	[488]	JMP  	  5		2	; 	goto 89
		 87	[488]	ISNES	  3		16	; if cname ~= ""
		 88	[488]	JMP  	  5		2	; 	goto 91
		 89	[490]	RET0 	  0		1	; return
		 90	[490]	JMP  	  5		11	; 	goto 102
		 91	[491]	TGETS	  5	0	7	; slot5 = self.tsv_cmds
		 92	[491]	TGETV	  5	5	3	; slot5 = self.tsv_cmds[cname]
		 93	[491]	IST  	   		5	; if slot5
		 94	[491]	JMP  	  5		7	; 	goto 102
		 95	[492]	KPRI 	  5		0	; slot5 = nil
		 96	[492]	GGET 	  6		25	; slot6 = _env["string"]
		 97	[492]	TGETS	  6	6	6	; slot6 = string.format
		 98	[492]	KSTR 	  7		5	; slot7 = "cmd %s not found in tsv_cmds"
		 99	[492]	MOV  	  8		3	; slot8 = cname
		100	[492]	CALL 	  6	0	3	; MULTRES = string.format(slot7, cname)
		101	[492]	RETM 	  5		1	; return , ...MULTRES
		102	[496]	TGETS	  5	0	7	; slot5 = self.tsv_cmds
		103	[496]	TGETV	  5	5	3	; slot5 = self.tsv_cmds[cname]
		104	[496]	TGETS	  5	5	4	; slot5 = slot5.parse_fn
		105	[498]	TNEW 	  6		0	; slot6 = new table( array: 0, dict: 1)
		106	[499]	TSETS	  3	6	3	; cmd.name = cname
		107	[500]	TSETS	  1	6	2	; cmd.tsv_row = row
		108	[501]	TSETS	  2	6	1	; cmd.tsv_row_idx = row_idx
		109	[504]	ISF  	   		5	; if not parse_fn
		110	[504]	JMP  	  7		12	; 	goto 123
		111	[505]	MOV  	  7		5	; slot7 = parse_fn
		112	[505]	MOV  	  8		0	; slot8 = self
		113	[505]	MOV  	  9		6	; slot9 = cmd
		114	[505]	MOV  	 10		1	; slot10 = row
		115	[505]	MOV  	 11		2	; slot11 = row_idx
		116	[505]	CALL 	  7	3	5	; slot7, slot8 = parse_fn(self, cmd, row, row_idx)
		117	[506]	ISF  	   		7	; if not err
		118	[506]	JMP  	  9		7	; 	goto 126
		119	[507]	KPRI 	  9		0	; slot9 = nil
		120	[507]	MOV  	 10		8	; slot10 = msg
		121	[507]	RET  	  9		3	; return slot9, msg
		122	[508]	JMP  	  7		3	; 	goto 126
		123	[510]	UGET 	  7		2	; slot7 = uv2"tsv_value_col"
		124	[510]	TGETV	  7	1	7	; slot7 = row[uv2"tsv_value_col"]
		125	[510]	TSETS	  7	6	0	; cmd.value = slot7
		126	[513]	RET1 	  6		2	; return cmd
	180	[449]	TSETS	 14	5	61	; wave_db.parse_cmd = slot14
	181	[525]	FNEW 	 14		58	; @./all/wave_db.lua:516-525: 2 args, 0 upvalues, 8 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-11:	self
		  0-11:	start_cmd
		  3-9:	<generator>
		  3-9:	<state>
		  3-9:	<control>
		  4-7:	i
		  4-7:	cmd
		;;;; instructions ;;;;
		  1	[517]	GGET 	  2		1	; slot2 = _env["ipairs"]
		  2	[517]	TGETS	  3	0	0	; slot3 = self.db_cmds
		  3	[517]	CALL 	  2	4	2	; slot2, slot3, slot4 = ipairs(self.db_cmds)
		  4	[517]	JMP  	  5		3	; 	goto 8
		  5	[519]	ISNEV	  1		6	; if start_cmd ~= cmd
		  6	[519]	JMP  	  7		1	; 	goto 8
		  7	[521]	RET1 	  5		2	; return i
		  8	[517]	ITERC	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		  9	[517]	ITERL	  5		-5	; slot4<control> = slot5; if slot5 != nil goto 5
		 10	[524]	KPRI 	  2		0	; slot2 = nil
		 11	[524]	RET1 	  2		2	; return slot2
	182	[516]	TSETS	 14	5	59	; wave_db.get_cmd_idx = slot14
	183	[539]	FNEW 	 14		56	; @./all/wave_db.lua:527-539: 3 args, 0 upvalues, 10 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-28:	self
		  0-28:	cname
		  0-28:	start_cmd
		  16-28:	start_idx
		  19-27:	<index>
		  19-27:	<limit>
		  19-27:	<step>
		  20-26:	i
		  22-26:	cmd
		;;;; instructions ;;;;
		  1	[528]	TGETS	  3	0	2	; slot3 = self.db_cmds
		  2	[528]	ISF  	   		3	; if not self.db_cmds
		  3	[528]	JMP  	  3		4	; 	goto 8
		  4	[528]	ISF  	   		1	; if not cname
		  5	[528]	JMP  	  3		2	; 	goto 8
		  6	[528]	IST  	   		2	; if start_cmd
		  7	[528]	JMP  	  3		1	; 	goto 9
		  8	[529]	RET0 	  0		1	; return
		  9	[531]	MOV  	  4		0	; slot4 = self
		 10	[531]	TGETS	  3	0	1	; slot3 = self.get_cmd_idx
		 11	[531]	MOV  	  5		2	; slot5 = start_cmd
		 12	[531]	CALL 	  3	2	3	; slot3 = self.get_cmd_idx(self, start_cmd)
		 13	[531]	IST  	   		3	; if slot3
		 14	[531]	JMP  	  4		2	; 	goto 17
		 15	[531]	TGETS	  3	0	2	; slot3 = self.db_cmds
		 16	[531]	LEN  	  3		3	; slot3 = #self.db_cmds
		 17	[532]	MOV  	  4		3	; slot4 = start_idx
		 18	[532]	KSHORT	  5		1	; slot5 = 1
		 19	[532]	KSHORT	  6		65535	; slot6 = 65535
		 20	[532]	FORI 	  4		7	; for slot7 = slot4,slot5,slot6 else goto 28
		 21	[533]	TGETS	  8	0	2	; slot8 = self.db_cmds
		 22	[533]	TGETV	  8	8	7	; slot8 = self.db_cmds[i]
		 23	[534]	TGETS	  9	8	0	; slot9 = cmd.name
		 24	[534]	ISNEV	  9		1	; if cmd.name ~= cname
		 25	[534]	JMP  	  9		1	; 	goto 27
		 26	[536]	RET1 	  8		2	; return cmd
		 27	[532]	FORL 	  4		-7	; slot7 = slot7 + slot6<step>; if cmp(slot7, sign slot6<step>,  slot5<limit>) goto 21
		 28	[539]	RET0 	  0		1	; return
	184	[527]	TSETS	 14	5	57	; wave_db.find_prev_cmd = slot14
	185	[547]	FNEW 	 14		54	; @./all/wave_db.lua:541-547: 2 args, 0 upvalues, 8 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-11:	self
		  0-11:	cname
		  3-10:	<generator>
		  3-10:	<state>
		  3-10:	<control>
		  4-8:	_
		  4-8:	cmd
		;;;; instructions ;;;;
		  1	[542]	GGET 	  2		2	; slot2 = _env["pairs"]
		  2	[542]	TGETS	  3	0	1	; slot3 = self.db_cmds
		  3	[542]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(self.db_cmds)
		  4	[542]	ISNEXT	  5		4	; Verify ITERN at 9; goto 9
		  5	[543]	TGETS	  7	6	0	; slot7 = cmd.name
		  6	[543]	ISNEV	  7		1	; if cmd.name ~= cname
		  7	[543]	JMP  	  7		1	; 	goto 9
		  8	[544]	RET1 	  6		2	; return cmd
		  9	[542]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		 10	[542]	ITERL	  5		-6	; slot4<control> = slot5; if slot5 != nil goto 5
		 11	[547]	RET0 	  0		1	; return
	186	[541]	TSETS	 14	5	55	; wave_db.find_first_cmd = slot14
	187	[568]	FNEW 	 14		52	; @./all/wave_db.lua:549-568: 2 args, 3 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	WS_DONE
		  2:	WS_REMOVED
		;;;; variable info ;;;;
		  0-42:	self
		  0-42:	wave_name
		  4-42:	ws
		  30-42:	next_idx
		  32-42:	next_cmd
		;;;; instructions ;;;;
		  1	[550]	MOV  	  3		0	; slot3 = self
		  2	[550]	TGETS	  2	0	9	; slot2 = self.get_wave_status
		  3	[550]	MOV  	  4		1	; slot4 = wave_name
		  4	[550]	CALL 	  2	2	3	; slot2 = self.get_wave_status(self, wave_name)
		  5	[551]	IST  	   		2	; if ws
		  6	[551]	JMP  	  3		7	; 	goto 14
		  7	[552]	UGET 	  3		0	; slot3 = uv0"log"
		  8	[552]	TGETS	  3	3	8	; slot3 = uv0"log".error
		  9	[552]	KSTR 	  4		7	; slot4 = "wave %s does not exist"
		 10	[552]	MOV  	  5		1	; slot5 = wave_name
		 11	[552]	CALL 	  3	1	3	;  = uv0"log".error(slot4, wave_name)
		 12	[553]	KPRI 	  3		0	; slot3 = nil
		 13	[553]	RET1 	  3		2	; return slot3
		 14	[555]	TGETS	  3	2	6	; slot3 = ws.state
		 15	[555]	UGET 	  4		1	; slot4 = uv1"WS_DONE"
		 16	[555]	ISEQV	  3		4	; if ws.state == uv1"WS_DONE"
		 17	[555]	JMP  	  3		4	; 	goto 22
		 18	[555]	TGETS	  3	2	6	; slot3 = ws.state
		 19	[555]	UGET 	  4		2	; slot4 = uv2"WS_REMOVED"
		 20	[555]	ISNEV	  3		4	; if ws.state ~= uv2"WS_REMOVED"
		 21	[555]	JMP  	  3		7	; 	goto 29
		 22	[556]	UGET 	  3		0	; slot3 = uv0"log"
		 23	[556]	TGETS	  3	3	5	; slot3 = uv0"log".debug
		 24	[556]	KSTR 	  4		4	; slot4 = "wave %s finished"
		 25	[556]	MOV  	  5		1	; slot5 = wave_name
		 26	[556]	CALL 	  3	1	3	;  = uv0"log".debug(slot4, wave_name)
		 27	[557]	KPRI 	  3		0	; slot3 = nil
		 28	[557]	RET1 	  3		2	; return slot3
		 29	[560]	TGETS	  3	2	3	; slot3 = ws.current_idx
		 30	[560]	ADDVN	  3	3	0	; slot3 = ws.current_idx + 1
		 31	[561]	TGETS	  4	0	2	; slot4 = self.db_cmds
		 32	[561]	TGETV	  4	4	3	; slot4 = self.db_cmds[next_idx]
		 33	[562]	ISF  	   		4	; if not next_cmd
		 34	[562]	JMP  	  5		3	; 	goto 38
		 35	[562]	TGETS	  5	4	1	; slot5 = next_cmd.name
		 36	[562]	ISNES	  5		0	; if next_cmd.name ~= "manual_wave"
		 37	[562]	JMP  	  5		2	; 	goto 40
		 38	[564]	KPRI 	  5		0	; slot5 = nil
		 39	[564]	RET1 	  5		2	; return slot5
		 40	[567]	MOV  	  5		4	; slot5 = next_cmd
		 41	[567]	MOV  	  6		3	; slot6 = next_idx
		 42	[567]	RET  	  5		3	; return next_cmd, next_idx
	188	[549]	TSETS	 14	5	53	; wave_db.peek_next_cmd = slot14
	189	[581]	FNEW 	 14		50	; @./all/wave_db.lua:570-581: 2 args, 0 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-16:	self
		  0-16:	wave_name
		  4-16:	next_cmd
		  4-16:	next_idx
		  12-16:	ws
		;;;; instructions ;;;;
		  1	[571]	MOV  	  3		0	; slot3 = self
		  2	[571]	TGETS	  2	0	2	; slot2 = self.peek_next_cmd
		  3	[571]	MOV  	  4		1	; slot4 = wave_name
		  4	[571]	CALL 	  2	3	3	; slot2, slot3 = self.peek_next_cmd(self, wave_name)
		  5	[572]	IST  	   		2	; if next_cmd
		  6	[572]	JMP  	  4		2	; 	goto 9
		  7	[573]	KPRI 	  4		0	; slot4 = nil
		  8	[573]	RET1 	  4		2	; return slot4
		  9	[577]	MOV  	  5		0	; slot5 = self
		 10	[577]	TGETS	  4	0	1	; slot4 = self.get_wave_status
		 11	[577]	MOV  	  6		1	; slot6 = wave_name
		 12	[577]	CALL 	  4	2	3	; slot4 = self.get_wave_status(self, wave_name)
		 13	[578]	TSETS	  3	4	0	; ws.current_idx = next_idx
		 14	[580]	MOV  	  5		2	; slot5 = next_cmd
		 15	[580]	MOV  	  6		3	; slot6 = next_idx
		 16	[580]	RET  	  5		3	; return next_cmd, next_idx
	190	[570]	TSETS	 14	5	51	; wave_db.get_next_cmd = slot14
	191	[663]	FNEW 	 14		48	; @./all/wave_db.lua:583-663: 4 args, 4 upvalues, 21 slots
		
		;;;; constant tables ;;;;
		ktable#27 = [
			[interval] = -1,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	tsv
		  1:	log
		  2:	log_e
		  3:	WS_RUNNING
		;;;; variable info ;;;;
		  0-173:	self
		  0-173:	level_name
		  0-173:	game_mode
		  0-173:	wave_ss_data
		  3-173:	rows
		  13-58:	suffix
		  20-58:	wn
		  25-58:	wf
		  70-173:	ws
		  77-173:	db
		  83-173:	sheet_name
		  86-143:	<index>
		  86-143:	<limit>
		  86-143:	<step>
		  87-142:	i
		  92-142:	cmd
		  92-142:	err
		  121-126:	mws
		  150-171:	out
		  153-166:	<generator>
		  153-166:	<state>
		  153-166:	<control>
		  154-164:	i
		  154-164:	cmd
		;;;; instructions ;;;;
		  1	[584]	KPRI 	  4		0	; slot4 = nil
		  2	[584]	TSETS	  4	0	52	; self.parse_errors = slot4
		  3	[586]	KPRI 	  4		0	; slot4 = nil
		  4	[587]	ISF  	   		3	; if not wave_ss_data
		  5	[587]	JMP  	  5		6	; 	goto 12
		  6	[590]	UGET 	  5		0	; slot5 = uv0"tsv"
		  7	[590]	TGETS	  5	5	51	; slot5 = uv0"tsv".parse_tsv
		  8	[590]	MOV  	  6		3	; slot6 = wave_ss_data
		  9	[590]	CALL 	  5	2	2	; slot5 = uv0"tsv".parse_tsv(wave_ss_data)
		 10	[590]	MOV  	  4		5	; slot4 = uv0"tsv".parse_tsv
		 11	[590]	JMP  	  5		47	; 	goto 59
		 12	[592]	TGETS	  5	0	50	; slot5 = self.gms
		 13	[592]	TGETV	  5	5	2	; slot5 = self.gms[game_mode]
		 14	[593]	GGET 	  6		49	; slot6 = _env["string"]
		 15	[593]	TGETS	  6	6	48	; slot6 = string.format
		 16	[593]	KSTR 	  7		47	; slot7 = "%s/data/waves/%s_waves_%s"
		 17	[593]	GGET 	  8		46	; slot8 = _env["KR_PATH_GAME"]
		 18	[593]	MOV  	  9		1	; slot9 = level_name
		 19	[593]	MOV  	 10		5	; slot10 = suffix
		 20	[593]	CALL 	  6	2	5	; slot6 = string.format(slot7, KR_PATH_GAME, level_name, suffix)
		 21	[594]	GGET 	  7		49	; slot7 = _env["string"]
		 22	[594]	TGETS	  7	7	48	; slot7 = string.format
		 23	[594]	KSTR 	  8		45	; slot8 = "%s.tsv"
		 24	[594]	MOV  	  9		6	; slot9 = wn
		 25	[594]	CALL 	  7	2	3	; slot7 = string.format(slot8, wn)
		 26	[595]	GGET 	  8		44	; slot8 = _env["love"]
		 27	[595]	TGETS	  8	8	43	; slot8 = love.filesystem
		 28	[595]	TGETS	  8	8	42	; slot8 = love.filesystem.isFile
		 29	[595]	MOV  	  9		7	; slot9 = wf
		 30	[595]	CALL 	  8	2	2	; slot8 = love.filesystem.isFile(wf)
		 31	[595]	IST  	   		8	; if love.filesystem.isFile
		 32	[595]	JMP  	  8		6	; 	goto 39
		 33	[596]	UGET 	  8		1	; slot8 = uv1"log"
		 34	[596]	TGETS	  8	8	41	; slot8 = uv1"log".info
		 35	[596]	KSTR 	  9		40	; slot9 = "wave file in tsv format not found: %s"
		 36	[596]	MOV  	 10		7	; slot10 = wf
		 37	[596]	CALL 	  8	1	3	;  = uv1"log".info(slot9, wf)
		 38	[597]	RET0 	  0		1	; return
		 39	[599]	UGET 	  8		1	; slot8 = uv1"log"
		 40	[599]	TGETS	  8	8	39	; slot8 = uv1"log".debug
		 41	[599]	KSTR 	  9		38	; slot9 = "Loading %s"
		 42	[599]	MOV  	 10		6	; slot10 = wn
		 43	[599]	CALL 	  8	1	3	;  = uv1"log".debug(slot9, wn)
		 44	[600]	UGET 	  8		0	; slot8 = uv0"tsv"
		 45	[600]	TGETS	  8	8	37	; slot8 = uv0"tsv".load
		 46	[600]	MOV  	  9		7	; slot9 = wf
		 47	[600]	CALL 	  8	2	2	; slot8 = uv0"tsv".load(wf)
		 48	[600]	MOV  	  4		8	; slot4 = uv0"tsv".load
		 49	[601]	ISF  	   		4	; if not rows
		 50	[601]	JMP  	  8		3	; 	goto 54
		 51	[601]	LEN  	  8		4	; slot8 = #rows
		 52	[601]	ISNEN	  8		0	; if slot8 ~= 0
		 53	[601]	JMP  	  8		5	; 	goto 59
		 54	[602]	UGET 	  8		2	; slot8 = uv2"log_e"
		 55	[602]	KSTR 	  9		36	; slot9 = "Failed to load %s"
		 56	[602]	MOV  	 10		7	; slot10 = wf
		 57	[602]	CALL 	  8	1	3	;  = uv2"log_e"(slot9, wf)
		 58	[603]	RET0 	  0		1	; return
		 59	[607]	KSTR 	  5		35	; slot5 = "tsv"
		 60	[607]	TSETS	  5	0	48	; self.format = slot5
		 61	[608]	TSETS	  2	0	34	; self.game_mode = game_mode
		 62	[609]	TSETS	  4	0	33	; self.db_rows = rows
		 63	[612]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		 64	[612]	TSETS	  5	0	32	; self.db_cmds = slot5
		 65	[614]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		 66	[614]	TSETS	  5	0	31	; self.db_waves_status = slot5
		 67	[615]	MOV  	  6		0	; slot6 = self
		 68	[615]	TGETS	  5	0	30	; slot5 = self.create_wave_status
		 69	[615]	KSTR 	  7		29	; slot7 = "main"
		 70	[615]	CALL 	  5	2	3	; slot5 = self.create_wave_status(self, slot7)
		 71	[616]	UGET 	  6		3	; slot6 = uv3"WS_RUNNING"
		 72	[616]	TSETS	  6	5	28	; ws.state = uv3"WS_RUNNING"
		 73	[619]	TDUP 	  6		27	; slot6 = copy table#k27
		 74	[620]	TNEW 	  7		0	; slot7 = new table( array: 0, dict: 1)
		 75	[620]	TSETS	  7	6	26	; slot6.path_columns = slot7
		 76	[622]	TNEW 	  7		0	; slot7 = new table( array: 0, dict: 1)
		 77	[622]	TSETS	  7	6	25	; slot6.flags_visibility = slot7
		 78	[624]	TSETS	  6	0	24	; self.db = db
		 79	[627]	UGET 	  7		1	; slot7 = uv1"log"
		 80	[627]	TGETS	  7	7	23	; slot7 = uv1"log".paranoid
		 81	[627]	KSTR 	  8		22	; slot8 = "parsing rows"
		 82	[627]	CALL 	  7	1	2	;  = uv1"log".paranoid(slot8)
		 83	[628]	KPRI 	  7		0	; slot7 = nil
		 84	[629]	KSHORT	  8		1	; slot8 = 1
		 85	[629]	LEN  	  9		4	; slot9 = #rows
		 86	[629]	KSHORT	 10		1	; slot10 = 1
		 87	[629]	FORI 	  8		56	; for slot11 = slot8,slot9,slot10 else goto 144
		 88	[630]	MOV  	 13		0	; slot13 = self
		 89	[630]	TGETS	 12	0	21	; slot12 = self.parse_cmd
		 90	[630]	TGETV	 14	4	11	; slot14 = rows[i]
		 91	[630]	MOV  	 15		11	; slot15 = i
		 92	[630]	CALL 	 12	3	4	; slot12, slot13 = self.parse_cmd(self, slot14, i)
		 93	[631]	ISF  	   		12	; if not cmd
		 94	[631]	JMP  	 14		33	; 	goto 128
		 95	[632]	UGET 	 14		1	; slot14 = uv1"log"
		 96	[632]	TGETS	 14	14	23	; slot14 = uv1"log".paranoid
		 97	[632]	KSTR 	 15		20	; slot15 = " row[%s] = %s"
		 98	[632]	MOV  	 16		11	; slot16 = i
		 99	[632]	GGET 	 17		19	; slot17 = _env["getdump"]
		100	[632]	MOV  	 18		12	; slot18 = cmd
		101	[632]	CALL 	 17	0	2	; MULTRES = getdump(cmd)
		102	[632]	CALLM	 14	1	2	;  = uv1"log".paranoid(slot15, i, ...MULTRES)
		103	[633]	TGETS	 14	12	18	; slot14 = cmd.name
		104	[633]	ISNES	 14		17	; if cmd.name ~= "sheet_name"
		105	[633]	JMP  	 14		1	; 	goto 107
		106	[634]	TGETS	  7	12	16	; slot7 = cmd.value
		107	[636]	TGETS	 14	12	18	; slot14 = cmd.name
		108	[636]	ISEQS	 14		15	; if cmd.name == "#"
		109	[636]	JMP  	 14		5	; 	goto 115
		110	[637]	GGET 	 14		14	; slot14 = _env["table"]
		111	[637]	TGETS	 14	14	13	; slot14 = table.insert
		112	[637]	TGETS	 15	0	32	; slot15 = self.db_cmds
		113	[637]	MOV  	 16		12	; slot16 = cmd
		114	[637]	CALL 	 14	1	3	;  = table.insert(self.db_cmds, cmd)
		115	[639]	TGETS	 14	12	18	; slot14 = cmd.name
		116	[639]	ISNES	 14		12	; if cmd.name ~= "manual_wave"
		117	[639]	JMP  	 14		25	; 	goto 143
		118	[640]	MOV  	 15		0	; slot15 = self
		119	[640]	TGETS	 14	0	30	; slot14 = self.create_wave_status
		120	[640]	TGETS	 16	12	11	; slot16 = cmd.wave_name
		121	[640]	CALL 	 14	2	3	; slot14 = self.create_wave_status(self, cmd.wave_name)
		122	[641]	TGETS	 15	0	32	; slot15 = self.db_cmds
		123	[641]	LEN  	 15		15	; slot15 = #self.db_cmds
		124	[641]	TSETS	 15	14	10	; mws.first_idx = slot15
		125	[642]	TGETS	 15	14	10	; slot15 = mws.first_idx
		126	[642]	TSETS	 15	14	9	; mws.current_idx = mws.first_idx
		127	[643]	JMP  	 14		15	; 	goto 143
		128	[645]	ISF  	   		13	; if not err
		129	[645]	JMP  	 14		7	; 	goto 137
		130	[646]	UGET 	 14		2	; slot14 = uv2"log_e"
		131	[646]	KSTR 	 15		8	; slot15 = "error at %s#%s:  %s"
		132	[646]	MOV  	 16		7	; slot16 = sheet_name
		133	[646]	MOV  	 17		11	; slot17 = i
		134	[646]	MOV  	 18		13	; slot18 = err
		135	[646]	CALL 	 14	1	5	;  = uv2"log_e"(slot15, sheet_name, i, err)
		136	[646]	JMP  	 14		6	; 	goto 143
		137	[648]	UGET 	 14		1	; slot14 = uv1"log"
		138	[648]	TGETS	 14	14	23	; slot14 = uv1"log".paranoid
		139	[648]	KSTR 	 15		7	; slot15 = "empty line at %s#%s"
		140	[648]	MOV  	 16		7	; slot16 = sheet_name
		141	[648]	MOV  	 17		11	; slot17 = i
		142	[648]	CALL 	 14	1	4	;  = uv1"log".paranoid(slot15, sheet_name, i)
		143	[629]	FORL 	  8		-56	; slot11 = slot11 + slot10<step>; if cmp(slot11, sign slot10<step>,  slot9<limit>) goto 88
		144	[654]	UGET 	  8		1	; slot8 = uv1"log"
		145	[654]	TGETS	  8	8	6	; slot8 = uv1"log".level
		146	[654]	UGET 	  9		1	; slot9 = uv1"log"
		147	[654]	TGETS	  9	9	5	; slot9 = uv1"log".PARANOID_LEVEL
		148	[654]	ISNEV	  8		9	; if uv1"log".level ~= uv1"log".PARANOID_LEVEL
		149	[654]	JMP  	  8		22	; 	goto 172
		150	[655]	KSTR 	  8		4	; slot8 = ""
		151	[656]	GGET 	  9		3	; slot9 = _env["ipairs"]
		152	[656]	TGETS	 10	0	32	; slot10 = self.db_cmds
		153	[656]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(self.db_cmds)
		154	[656]	JMP  	 12		10	; 	goto 165
		155	[657]	MOV  	 14		8	; slot14 = out
		156	[657]	GGET 	 15		49	; slot15 = _env["string"]
		157	[657]	TGETS	 15	15	48	; slot15 = string.format
		158	[657]	KSTR 	 16		2	; slot16 = "(%02i) - %s : value:%s wait_time:%s
		"
		159	[657]	MOV  	 17		12	; slot17 = i
		160	[657]	TGETS	 18	13	18	; slot18 = cmd.name
		161	[657]	TGETS	 19	13	16	; slot19 = cmd.value
		162	[657]	TGETS	 20	13	1	; slot20 = cmd.wait_time
		163	[657]	CALL 	 15	2	6	; slot15 = string.format(slot16, i, cmd.name, cmd.value, cmd.wait_time)
		164	[657]	CAT  	  8	14	15	; slot8 = out .. string.format
		165	[656]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		166	[656]	ITERL	 12		-12	; slot11<control> = self.parse_cmd; if self.parse_cmd != nil goto 155
		167	[659]	UGET 	  9		1	; slot9 = uv1"log"
		168	[659]	TGETS	  9	9	23	; slot9 = uv1"log".paranoid
		169	[659]	KSTR 	 10		0	; slot10 = "wave cmds:
		%s"
		170	[659]	MOV  	 11		8	; slot11 = out
		171	[659]	CALL 	  9	1	3	;  = uv1"log".paranoid(slot10, out)
		172	[662]	KPRI 	  8		2	; slot8 = true
		173	[662]	RET1 	  8		2	; return slot8
	192	[583]	TSETS	 14	5	49	; wave_db.load_tsv = slot14
	193	[708]	FNEW 	 14		46	; @./all/wave_db.lua:665-708: 3 args, 3 upvalues, 16 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	FS
		  2:	wave_db
		;;;; variable info ;;;;
		  0-114:	self
		  0-114:	level_name
		  0-114:	game_mode
		  2-114:	suffix
		  9-114:	wn
		  14-114:	wf
		  20-114:	ok
		  20-114:	wchunk
		  20-114:	wtable
		  20-114:	extraw
		  62-114:	wen
		  67-114:	wef
		;;;; instructions ;;;;
		  1	[667]	TGETS	  3	0	21	; slot3 = self.gms
		  2	[667]	TGETV	  3	3	2	; slot3 = self.gms[game_mode]
		  3	[668]	GGET 	  4		20	; slot4 = _env["string"]
		  4	[668]	TGETS	  4	4	19	; slot4 = string.format
		  5	[668]	KSTR 	  5		18	; slot5 = "%s/data/waves/%s_waves_%s"
		  6	[668]	GGET 	  6		17	; slot6 = _env["KR_PATH_GAME"]
		  7	[668]	MOV  	  7		1	; slot7 = level_name
		  8	[668]	MOV  	  8		3	; slot8 = suffix
		  9	[668]	CALL 	  4	2	5	; slot4 = string.format(slot5, KR_PATH_GAME, level_name, suffix)
		 10	[669]	GGET 	  5		20	; slot5 = _env["string"]
		 11	[669]	TGETS	  5	5	19	; slot5 = string.format
		 12	[669]	KSTR 	  6		16	; slot6 = "%s.lua"
		 13	[669]	MOV  	  7		4	; slot7 = wn
		 14	[669]	CALL 	  5	2	3	; slot5 = string.format(slot6, wn)
		 15	[671]	UGET 	  6		0	; slot6 = uv0"log"
		 16	[671]	TGETS	  6	6	15	; slot6 = uv0"log".debug
		 17	[671]	KSTR 	  7		14	; slot7 = "Loading %s"
		 18	[671]	MOV  	  8		4	; slot8 = wn
		 19	[671]	CALL 	  6	1	3	;  = uv0"log".debug(slot7, wn)
		 20	[672]	KNIL 	  6		9	; uv0"log".debug, slot7, wn, slot9 = nil
		 21	[674]	GGET 	 10		13	; slot10 = _env["pcall"]
		 22	[674]	UGET 	 11		1	; slot11 = uv1"FS"
		 23	[674]	TGETS	 11	11	12	; slot11 = uv1"FS".load
		 24	[674]	MOV  	 12		5	; slot12 = wf
		 25	[674]	CALL 	 10	3	3	; slot10, slot11 = pcall(uv1"FS".load, wf)
		 26	[674]	MOV  	  7		11	; slot7 = uv1"FS".load
		 27	[674]	MOV  	  6		10	; slot6 = pcall
		 28	[675]	IST  	   		6	; if ok
		 29	[675]	JMP  	 10		7	; 	goto 37
		 30	[676]	UGET 	 10		0	; slot10 = uv0"log"
		 31	[676]	TGETS	 10	10	11	; slot10 = uv0"log".error
		 32	[676]	KSTR 	 11		10	; slot11 = "Failed to load %s: error: %s"
		 33	[676]	MOV  	 12		5	; slot12 = wf
		 34	[676]	MOV  	 13		7	; slot13 = wchunk
		 35	[676]	CALL 	 10	1	4	;  = uv0"log".error(slot11, wf, wchunk)
		 36	[677]	RET0 	  0		1	; return
		 37	[679]	GGET 	 10		13	; slot10 = _env["pcall"]
		 38	[679]	MOV  	 11		7	; slot11 = wchunk
		 39	[679]	CALL 	 10	3	2	; slot10, slot11 = pcall(wchunk)
		 40	[679]	MOV  	  8		11	; slot8 = wchunk
		 41	[679]	MOV  	  6		10	; slot6 = pcall
		 42	[680]	IST  	   		6	; if ok
		 43	[680]	JMP  	 10		7	; 	goto 51
		 44	[681]	UGET 	 10		0	; slot10 = uv0"log"
		 45	[681]	TGETS	 10	10	11	; slot10 = uv0"log".error
		 46	[681]	KSTR 	 11		9	; slot11 = "Failed to eval chunk for %s: error: %s"
		 47	[681]	MOV  	 12		5	; slot12 = wf
		 48	[681]	MOV  	 13		8	; slot13 = wtable
		 49	[681]	CALL 	 10	1	4	;  = uv0"log".error(slot11, wf, wtable)
		 50	[682]	RET0 	  0		1	; return
		 51	[685]	UGET 	 10		2	; slot10 = uv2"wave_db"
		 52	[685]	KSTR 	 11		8	; slot11 = "lua"
		 53	[685]	TSETS	 11	10	19	; uv2"wave_db".format = slot11
		 54	[686]	UGET 	 10		2	; slot10 = uv2"wave_db"
		 55	[686]	TSETS	  2	10	7	; uv2"wave_db".game_mode = game_mode
		 56	[687]	UGET 	 10		2	; slot10 = uv2"wave_db"
		 57	[687]	TSETS	  8	10	6	; uv2"wave_db".db = wtable
		 58	[690]	GGET 	 10		20	; slot10 = _env["string"]
		 59	[690]	TGETS	 10	10	19	; slot10 = string.format
		 60	[690]	KSTR 	 11		5	; slot11 = "%s_extra"
		 61	[690]	MOV  	 12		4	; slot12 = wn
		 62	[690]	CALL 	 10	2	3	; slot10 = string.format(slot11, wn)
		 63	[691]	GGET 	 11		20	; slot11 = _env["string"]
		 64	[691]	TGETS	 11	11	19	; slot11 = string.format
		 65	[691]	KSTR 	 12		16	; slot12 = "%s.lua"
		 66	[691]	MOV  	 13		10	; slot13 = wen
		 67	[691]	CALL 	 11	2	3	; slot11 = string.format(slot12, wen)
		 68	[692]	UGET 	 12		1	; slot12 = uv1"FS"
		 69	[692]	TGETS	 12	12	4	; slot12 = uv1"FS".isFile
		 70	[692]	MOV  	 13		11	; slot13 = wef
		 71	[692]	CALL 	 12	2	2	; slot12 = uv1"FS".isFile(wef)
		 72	[692]	ISF  	   		12	; if not uv1"FS".isFile
		 73	[692]	JMP  	 13		39	; 	goto 113
		 74	[693]	UGET 	 12		0	; slot12 = uv0"log"
		 75	[693]	TGETS	 12	12	3	; slot12 = uv0"log".info
		 76	[693]	KSTR 	 13		2	; slot13 = "Found extra waves: %s"
		 77	[693]	MOV  	 14		11	; slot14 = wef
		 78	[693]	CALL 	 12	1	3	;  = uv0"log".info(slot13, wef)
		 79	[694]	GGET 	 12		13	; slot12 = _env["pcall"]
		 80	[694]	UGET 	 13		1	; slot13 = uv1"FS"
		 81	[694]	TGETS	 13	13	12	; slot13 = uv1"FS".load
		 82	[694]	MOV  	 14		11	; slot14 = wef
		 83	[694]	CALL 	 12	3	3	; slot12, slot13 = pcall(uv1"FS".load, wef)
		 84	[694]	MOV  	  7		13	; slot7 = uv1"FS".load
		 85	[694]	MOV  	  6		12	; slot6 = pcall
		 86	[695]	IST  	   		6	; if ok
		 87	[695]	JMP  	 12		7	; 	goto 95
		 88	[696]	UGET 	 12		0	; slot12 = uv0"log"
		 89	[696]	TGETS	 12	12	11	; slot12 = uv0"log".error
		 90	[696]	KSTR 	 13		10	; slot13 = "Failed to load %s: error: %s"
		 91	[696]	MOV  	 14		11	; slot14 = wef
		 92	[696]	MOV  	 15		7	; slot15 = wchunk
		 93	[696]	CALL 	 12	1	4	;  = uv0"log".error(slot13, wef, wchunk)
		 94	[697]	RET0 	  0		1	; return
		 95	[699]	GGET 	 12		13	; slot12 = _env["pcall"]
		 96	[699]	MOV  	 13		7	; slot13 = wchunk
		 97	[699]	CALL 	 12	3	2	; slot12, slot13 = pcall(wchunk)
		 98	[699]	MOV  	  9		13	; slot9 = wchunk
		 99	[699]	MOV  	  6		12	; slot6 = pcall
		100	[700]	IST  	   		6	; if ok
		101	[700]	JMP  	 12		7	; 	goto 109
		102	[701]	UGET 	 12		0	; slot12 = uv0"log"
		103	[701]	TGETS	 12	12	11	; slot12 = uv0"log".error
		104	[701]	KSTR 	 13		1	; slot13 = "Failed to eval extra waves chunk for %s: error: %s"
		105	[701]	MOV  	 14		11	; slot14 = wef
		106	[701]	MOV  	 15		9	; slot15 = extraw
		107	[701]	CALL 	 12	1	4	;  = uv0"log".error(slot13, wef, extraw)
		108	[702]	RET0 	  0		1	; return
		109	[704]	MOV  	 13		0	; slot13 = self
		110	[704]	TGETS	 12	0	0	; slot12 = self.add_waves_to_groups
		111	[704]	MOV  	 14		9	; slot14 = extraw
		112	[704]	CALL 	 12	1	3	;  = self.add_waves_to_groups(self, extraw)
		113	[707]	KPRI 	 12		2	; slot12 = true
		114	[707]	RET1 	 12		2	; return slot12
	194	[665]	TSETS	 14	5	47	; wave_db.load_lua = slot14
	195	[721]	FNEW 	 14		44	; @./all/wave_db.lua:710-721: 4 args, 1 upvalues, 9 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-29:	self
		  0-29:	level_name
		  0-29:	game_mode
		  0-29:	wave_ss_data
		;;;; instructions ;;;;
		  1	[712]	MOV  	  5		0	; slot5 = self
		  2	[712]	TGETS	  4	0	6	; slot4 = self.load_tsv
		  3	[712]	MOV  	  6		1	; slot6 = level_name
		  4	[712]	MOV  	  7		2	; slot7 = game_mode
		  5	[712]	MOV  	  8		3	; slot8 = wave_ss_data
		  6	[712]	CALL 	  4	2	5	; slot4 = self.load_tsv(self, level_name, game_mode, wave_ss_data)
		  7	[712]	ISF  	   		4	; if not slot4
		  8	[712]	JMP  	  5		6	; 	goto 15
		  9	[713]	UGET 	  4		0	; slot4 = uv0"log"
		 10	[713]	TGETS	  4	4	5	; slot4 = uv0"log".debug
		 11	[713]	KSTR 	  5		4	; slot5 = "loaded waves file in tsv format"
		 12	[713]	CALL 	  4	1	2	;  = uv0"log".debug(slot5)
		 13	[714]	KSTR 	  4		3	; slot4 = "tsv"
		 14	[714]	RET1 	  4		2	; return slot4
		 15	[716]	MOV  	  5		0	; slot5 = self
		 16	[716]	TGETS	  4	0	2	; slot4 = self.load_lua
		 17	[716]	MOV  	  6		1	; slot6 = level_name
		 18	[716]	MOV  	  7		2	; slot7 = game_mode
		 19	[716]	CALL 	  4	2	4	; slot4 = self.load_lua(self, level_name, game_mode)
		 20	[716]	ISF  	   		4	; if not slot4
		 21	[716]	JMP  	  5		6	; 	goto 28
		 22	[717]	UGET 	  4		0	; slot4 = uv0"log"
		 23	[717]	TGETS	  4	4	5	; slot4 = uv0"log".debug
		 24	[717]	KSTR 	  5		1	; slot5 = "loaded waves file in lua format"
		 25	[717]	CALL 	  4	1	2	;  = uv0"log".debug(slot5)
		 26	[718]	KSTR 	  4		0	; slot4 = "lua"
		 27	[718]	RET1 	  4		2	; return slot4
		 28	[720]	KPRI 	  4		0	; slot4 = nil
		 29	[720]	RET1 	  4		2	; return slot4
	196	[710]	TSETS	 14	5	45	; wave_db.load = slot14
	197	[747]	FNEW 	 14		42	; @./all/wave_db.lua:726-747: 2 args, 1 upvalues, 15 slots
		
		;;;; constant tables ;;;;
		ktable#3 = [
			]
		
		
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-61:	self
		  0-61:	gwaves
		  15-55:	<generator>
		  15-55:	<state>
		  15-55:	<control>
		  16-53:	g
		  16-53:	more_waves
		  42-53:	<generator>
		  42-53:	<state>
		  42-53:	<control>
		  43-51:	_
		  43-51:	w
		;;;; instructions ;;;;
		  1	[727]	TGETS	  2	0	15	; slot2 = self.format
		  2	[727]	ISEQS	  2		14	; if self.format == "lua"
		  3	[727]	JMP  	  2		5	; 	goto 9
		  4	[728]	UGET 	  2		0	; slot2 = uv0"log"
		  5	[728]	TGETS	  2	2	13	; slot2 = uv0"log".error
		  6	[728]	KSTR 	  3		12	; slot3 = "TODO: Only implemented for lua format"
		  7	[728]	CALL 	  2	1	2	;  = uv0"log".error(slot3)
		  8	[729]	RET0 	  0		1	; return
		  9	[731]	TGETS	  2	0	11	; slot2 = self.db
		 10	[731]	TGETS	  2	2	10	; slot2 = self.db.groups
		 11	[731]	ISF  	   		2	; if not self.db.groups
		 12	[731]	JMP  	  3		44	; 	goto 57
		 13	[732]	GGET 	  2		9	; slot2 = _env["pairs"]
		 14	[732]	MOV  	  3		1	; slot3 = gwaves
		 15	[732]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(gwaves)
		 16	[732]	ISNEXT	  5		37	; Verify ITERN at 54; goto 54
		 17	[733]	UGET 	  7		0	; slot7 = uv0"log"
		 18	[733]	TGETS	  7	7	8	; slot7 = uv0"log".info
		 19	[733]	KSTR 	  8		7	; slot8 = "adding %d extra waves to group %d"
		 20	[733]	TGETS	  9	6	6	; slot9 = more_waves.waves
		 21	[733]	LEN  	  9		9	; slot9 = #more_waves.waves
		 22	[733]	MOV  	 10		5	; slot10 = g
		 23	[733]	CALL 	  7	1	4	;  = uv0"log".info(slot8, slot9, g)
		 24	[734]	TGETS	  7	0	11	; slot7 = self.db
		 25	[734]	TGETS	  7	7	10	; slot7 = self.db.groups
		 26	[734]	TGETV	  7	7	5	; slot7 = self.db.groups[g]
		 27	[734]	IST  	   		7	; if slot7
		 28	[734]	JMP  	  7		11	; 	goto 40
		 29	[735]	UGET 	  7		0	; slot7 = uv0"log"
		 30	[735]	TGETS	  7	7	5	; slot7 = uv0"log".warning
		 31	[735]	KSTR 	  8		4	; slot8 = "Adding waves to inexistent group %d"
		 32	[735]	MOV  	  9		5	; slot9 = g
		 33	[735]	CALL 	  7	1	3	;  = uv0"log".warning(slot8, g)
		 34	[736]	TGETS	  7	0	11	; slot7 = self.db
		 35	[736]	TGETS	  7	7	10	; slot7 = self.db.groups
		 36	[736]	TDUP 	  8		3	; slot8 = copy table#k3
		 37	[736]	TNEW 	  9		0	; slot9 = new table( array: 0, dict: 1)
		 38	[736]	TSETS	  9	8	6	; slot8.waves = slot9
		 39	[736]	TSETV	  8	7	5	; self.db.groups[g] = slot8
		 40	[740]	GGET 	  7		9	; slot7 = _env["pairs"]
		 41	[740]	TGETS	  8	6	6	; slot8 = more_waves.waves
		 42	[740]	CALL 	  7	4	2	; slot7, slot8, slot9 = pairs(more_waves.waves)
		 43	[740]	ISNEXT	 10		8	; Verify ITERN at 52; goto 52
		 44	[741]	GGET 	 12		2	; slot12 = _env["table"]
		 45	[741]	TGETS	 12	12	1	; slot12 = table.insert
		 46	[741]	TGETS	 13	0	11	; slot13 = self.db
		 47	[741]	TGETS	 13	13	10	; slot13 = self.db.groups
		 48	[741]	TGETV	 13	13	5	; slot13 = self.db.groups[g]
		 49	[741]	TGETS	 13	13	6	; slot13 = slot13.waves
		 50	[741]	MOV  	 14		11	; slot14 = w
		 51	[741]	CALL 	 12	1	3	;  = table.insert(<unknown table>.waves, w)
		 52	[740]	ITERN	 10	3	3	; slot10, slot11, slot12 = slot7<generator>, slot8<state>, slot9<control>; slot10, slot11 = slot7<generator>(slot8<state>, slot9<control>)
		 53	[740]	ITERL	 10		-10	; slot9<control> = g; if g != nil goto 44
		 54	[732]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		 55	[732]	ITERL	  5		-39	; slot4<control> = slot5; if slot5 != nil goto 17
		 56	[743]	JMP  	  2		4	; 	goto 61
		 57	[745]	UGET 	  2		0	; slot2 = uv0"log"
		 58	[745]	TGETS	  2	2	13	; slot2 = uv0"log".error
		 59	[745]	KSTR 	  3		0	; slot3 = "Unable to add waves. No wave groups have been loaded yet."
		 60	[745]	CALL 	  2	1	2	;  = uv0"log".error(slot3)
		 61	[747]	RET0 	  0		1	; return
	198	[726]	TSETS	 14	5	43	; wave_db.add_waves_to_groups = slot14
	199	[755]	FNEW 	 14		40	; @./all/wave_db.lua:749-755: 1 args, 1 upvalues, 3 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-12:	self
		;;;; instructions ;;;;
		  1	[750]	TGETS	  1	0	5	; slot1 = self.format
		  2	[750]	ISEQS	  1		4	; if self.format == "lua"
		  3	[750]	JMP  	  1		6	; 	goto 10
		  4	[751]	UGET 	  1		0	; slot1 = uv0"log"
		  5	[751]	TGETS	  1	1	3	; slot1 = uv0"log".error
		  6	[751]	KSTR 	  2		2	; slot2 = "TODO: Only implemented for lua format"
		  7	[751]	CALL 	  1	1	2	;  = uv0"log".error(slot2)
		  8	[752]	TNEW 	  1		0	; slot1 = new table( array: 0, dict: 1)
		  9	[752]	RET1 	  1		2	; return slot1
		 10	[754]	TGETS	  1	0	1	; slot1 = self.db
		 11	[754]	TGETS	  1	1	0	; slot1 = self.db.groups
		 12	[754]	RET1 	  1		2	; return self.db.groups
	200	[749]	TSETS	 14	5	41	; wave_db.groups = slot14
	201	[763]	FNEW 	 14		38	; @./all/wave_db.lua:757-763: 2 args, 1 upvalues, 4 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-13:	self
		  0-13:	group_number
		;;;; instructions ;;;;
		  1	[758]	TGETS	  2	0	5	; slot2 = self.format
		  2	[758]	ISEQS	  2		4	; if self.format == "lua"
		  3	[758]	JMP  	  2		6	; 	goto 10
		  4	[759]	UGET 	  2		0	; slot2 = uv0"log"
		  5	[759]	TGETS	  2	2	3	; slot2 = uv0"log".error
		  6	[759]	KSTR 	  3		2	; slot3 = "TODO: Only implemented for lua format"
		  7	[759]	CALL 	  2	1	2	;  = uv0"log".error(slot3)
		  8	[760]	KPRI 	  2		0	; slot2 = nil
		  9	[760]	RET1 	  2		2	; return slot2
		 10	[762]	TGETS	  2	0	1	; slot2 = self.db
		 11	[762]	TGETS	  2	2	0	; slot2 = self.db.groups
		 12	[762]	TGETV	  2	2	1	; slot2 = self.db.groups[group_number]
		 13	[762]	RET1 	  2		2	; return slot2
	202	[757]	TSETS	 14	5	39	; wave_db.group = slot14
	203	[776]	FNEW 	 14		36	; @./all/wave_db.lua:765-776: 1 args, 0 upvalues, 4 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-23:	self
		  7-14:	cmd
		;;;; instructions ;;;;
		  1	[766]	TGETS	  1	0	6	; slot1 = self.format
		  2	[766]	ISNES	  1		5	; if self.format ~= "tsv"
		  3	[766]	JMP  	  1		12	; 	goto 16
		  4	[767]	MOV  	  2		0	; slot2 = self
		  5	[767]	TGETS	  1	0	4	; slot1 = self.find_first_cmd
		  6	[767]	KSTR 	  3		3	; slot3 = "gold"
		  7	[767]	CALL 	  1	2	3	; slot1 = self.find_first_cmd(self, slot3)
		  8	[768]	ISF  	   		1	; if not cmd
		  9	[768]	JMP  	  2		3	; 	goto 13
		 10	[769]	TGETS	  2	1	2	; slot2 = cmd.value
		 11	[769]	RET1 	  2		2	; return cmd.value
		 12	[769]	JMP  	  2		10	; 	goto 23
		 13	[771]	KSHORT	  2		0	; slot2 = 0
		 14	[771]	RET1 	  2		2	; return slot2
		 15	[772]	JMP  	  1		7	; 	goto 23
		 16	[774]	TGETS	  1	0	1	; slot1 = self.db
		 17	[774]	TGETS	  1	1	0	; slot1 = self.db.cash
		 18	[774]	IST  	   		1	; if self.db.cash
		 19	[774]	JMP  	  2		2	; 	goto 22
		 20	[774]	TGETS	  1	0	1	; slot1 = self.db
		 21	[774]	TGETS	  1	1	3	; slot1 = self.db.gold
		 22	[774]	RET1 	  1		2	; return self.db.gold
		 23	[776]	RET0 	  0		1	; return
	204	[765]	TSETS	 14	5	37	; wave_db.initial_gold = slot14
	205	[781]	FNEW 	 14		34	; @./all/wave_db.lua:778-781: 1 args, 0 upvalues, 2 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-3:	self
		;;;; instructions ;;;;
		  1	[780]	TGETS	  1	0	1	; slot1 = self.db
		  2	[780]	TGETS	  1	1	0	; slot1 = self.db.lifes
		  3	[780]	RET1 	  1		2	; return self.db.lifes
	206	[778]	TSETS	 14	5	35	; wave_db.initial_lives = slot14
	207	[791]	FNEW 	 14		32	; @./all/wave_db.lua:783-791: 1 args, 0 upvalues, 4 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-13:	self
		  7-11:	cmd
		;;;; instructions ;;;;
		  1	[784]	TGETS	  1	0	4	; slot1 = self.format
		  2	[784]	ISNES	  1		3	; if self.format ~= "tsv"
		  3	[784]	JMP  	  1		8	; 	goto 12
		  4	[785]	MOV  	  2		0	; slot2 = self
		  5	[785]	TGETS	  1	0	2	; slot1 = self.find_first_cmd
		  6	[785]	KSTR 	  3		1	; slot3 = "gem_keepers"
		  7	[785]	CALL 	  1	2	3	; slot1 = self.find_first_cmd(self, slot3)
		  8	[786]	ISF  	   		1	; if not cmd
		  9	[786]	JMP  	  2		2	; 	goto 12
		 10	[787]	TGETS	  2	1	0	; slot2 = cmd.value
		 11	[787]	RET1 	  2		2	; return cmd.value
		 12	[790]	KSHORT	  1		1	; slot1 = 1
		 13	[790]	RET1 	  1		2	; return slot1
	208	[783]	TSETS	 14	5	33	; wave_db.get_gem_keepers = slot14
	209	[809]	FNEW 	 14		30	; @./all/wave_db.lua:793-809: 1 args, 0 upvalues, 8 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-28:	self
		  11-22:	count
		  14-21:	<generator>
		  14-21:	<state>
		  14-21:	<control>
		  15-19:	_
		  15-19:	cmd
		;;;; instructions ;;;;
		  1	[794]	TGETS	  1	0	9	; slot1 = self.game_mode
		  2	[794]	GGET 	  2		8	; slot2 = _env["GAME_MODE_ENDLESS"]
		  3	[794]	ISNEV	  1		2	; if self.game_mode ~= GAME_MODE_ENDLESS
		  4	[794]	JMP  	  1		3	; 	goto 8
		  5	[795]	KSHORT	  1		0	; slot1 = 0
		  6	[795]	RET1 	  1		2	; return slot1
		  7	[795]	JMP  	  1		20	; 	goto 28
		  8	[797]	TGETS	  1	0	7	; slot1 = self.format
		  9	[797]	ISNES	  1		6	; if self.format ~= "tsv"
		 10	[797]	JMP  	  1		13	; 	goto 24
		 11	[798]	KSHORT	  1		0	; slot1 = 0
		 12	[799]	GGET 	  2		5	; slot2 = _env["ipairs"]
		 13	[799]	TGETS	  3	0	4	; slot3 = self.db_cmds
		 14	[799]	CALL 	  2	4	2	; slot2, slot3, slot4 = ipairs(self.db_cmds)
		 15	[799]	JMP  	  5		4	; 	goto 20
		 16	[800]	TGETS	  7	6	3	; slot7 = cmd.name
		 17	[800]	ISNES	  7		2	; if cmd.name ~= "wave"
		 18	[800]	JMP  	  7		1	; 	goto 20
		 19	[801]	ADDVN	  1	1	0	; slot1 = count + 1
		 20	[799]	ITERC	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		 21	[799]	ITERL	  5		-6	; slot4<control> = slot5; if slot5 != nil goto 16
		 22	[804]	RET1 	  1		2	; return count
		 23	[804]	JMP  	  1		4	; 	goto 28
		 24	[806]	TGETS	  1	0	1	; slot1 = self.db
		 25	[806]	TGETS	  1	1	0	; slot1 = self.db.groups
		 26	[806]	LEN  	  1		1	; slot1 = #self.db.groups
		 27	[806]	RET1 	  1		2	; return slot1
		 28	[809]	RET0 	  0		1	; return
	210	[793]	TSETS	 14	5	31	; wave_db.groups_count = slot14
	211	[831]	FNEW 	 14		28	; @./all/wave_db.lua:811-831: 1 args, 0 upvalues, 8 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-27:	self
		  15-26:	result
		  19-25:	<generator>
		  19-25:	<state>
		  19-25:	<control>
		  20-23:	__
		  20-23:	group
		;;;; instructions ;;;;
		  1	[812]	TGETS	  1	0	8	; slot1 = self.game_mode
		  2	[812]	GGET 	  2		7	; slot2 = _env["GAME_MODE_ENDLESS"]
		  3	[812]	ISNEV	  1		2	; if self.game_mode ~= GAME_MODE_ENDLESS
		  4	[812]	JMP  	  1		3	; 	goto 8
		  5	[813]	KSHORT	  1		0	; slot1 = 0
		  6	[813]	RET1 	  1		2	; return slot1
		  7	[813]	JMP  	  1		19	; 	goto 27
		  8	[815]	TGETS	  1	0	6	; slot1 = self.format
		  9	[815]	ISNES	  1		5	; if self.format ~= "tsv"
		 10	[815]	JMP  	  1		4	; 	goto 15
		 11	[822]	MOV  	  2		0	; slot2 = self
		 12	[822]	TGETS	  1	0	4	; slot1 = self.groups_count
		 13	[822]	CALLT	  1		2	; return self.groups_count(self)
		 14	[822]	JMP  	  1		12	; 	goto 27
		 15	[824]	KSHORT	  1		0	; slot1 = 0
		 16	[825]	GGET 	  2		3	; slot2 = _env["pairs"]
		 17	[825]	TGETS	  3	0	2	; slot3 = self.db
		 18	[825]	TGETS	  3	3	1	; slot3 = self.db.groups
		 19	[825]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(self.db.groups)
		 20	[825]	ISNEXT	  5		3	; Verify ITERN at 24; goto 24
		 21	[826]	TGETS	  7	6	0	; slot7 = group.waves
		 22	[826]	LEN  	  7		7	; slot7 = #group.waves
		 23	[826]	ADDVV	  1	1	7	; slot1 = result + slot7
		 24	[825]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		 25	[825]	ITERL	  5		-5	; slot4<control> = slot5; if slot5 != nil goto 21
		 26	[828]	RET1 	  1		2	; return result
		 27	[831]	RET0 	  0		1	; return
	212	[811]	TSETS	 14	5	29	; wave_db.all_waves_count = slot14
	213	[839]	FNEW 	 14		26	; @./all/wave_db.lua:833-839: 2 args, 0 upvalues, 4 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-22:	self
		  0-22:	i
		;;;; instructions ;;;;
		  1	[834]	TGETS	  2	0	2	; slot2 = self.game_mode
		  2	[834]	GGET 	  3		1	; slot3 = _env["GAME_MODE_ENDLESS"]
		  3	[834]	ISNEV	  2		3	; if self.game_mode ~= GAME_MODE_ENDLESS
		  4	[834]	JMP  	  2		8	; 	goto 13
		  5	[835]	KSHORT	  2		0	; slot2 = 0
		  6	[835]	ISLT 	  2		1	; if slot2 < i
		  7	[835]	JMP  	  2		2	; 	goto 10
		  8	[835]	KPRI 	  2		1	; slot2 = false
		  9	[835]	JMP  	  3		1	; 	goto 11
		 10	[835]	KPRI 	  2		2	; slot2 = true
		 11	[835]	RET1 	  2		2	; return slot2
		 12	[835]	JMP  	  2		9	; 	goto 22
		 13	[837]	MOV  	  3		0	; slot3 = self
		 14	[837]	TGETS	  2	0	0	; slot2 = self.groups_count
		 15	[837]	CALL 	  2	2	2	; slot2 = self.groups_count(self)
		 16	[837]	ISLE 	  1		2	; if i <= slot2
		 17	[837]	JMP  	  2		2	; 	goto 20
		 18	[837]	KPRI 	  2		1	; slot2 = false
		 19	[837]	JMP  	  3		1	; 	goto 21
		 20	[837]	KPRI 	  2		2	; slot2 = true
		 21	[837]	RET1 	  2		2	; return slot2
		 22	[839]	RET0 	  0		1	; return
	214	[833]	TSETS	 14	5	27	; wave_db.has_group = slot14
	215	[850]	FNEW 	 14		24	; @./all/wave_db.lua:841-850: 2 args, 1 upvalues, 5 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-24:	self
		  0-24:	i
		;;;; instructions ;;;;
		  1	[842]	TGETS	  2	0	8	; slot2 = self.game_mode
		  2	[842]	GGET 	  3		7	; slot3 = _env["GAME_MODE_ENDLESS"]
		  3	[842]	ISNEV	  2		3	; if self.game_mode ~= GAME_MODE_ENDLESS
		  4	[842]	JMP  	  2		5	; 	goto 10
		  5	[843]	MOV  	  3		0	; slot3 = self
		  6	[843]	TGETS	  2	0	6	; slot2 = self.get_endless_group
		  7	[843]	MOV  	  4		1	; slot4 = i
		  8	[843]	CALLT	  2		3	; return self.get_endless_group(self, i)
		  9	[843]	JMP  	  2		14	; 	goto 24
		 10	[844]	TGETS	  2	0	5	; slot2 = self.format
		 11	[844]	ISNES	  2		4	; if self.format ~= "tsv"
		 12	[844]	JMP  	  2		7	; 	goto 20
		 13	[845]	UGET 	  2		0	; slot2 = uv0"log"
		 14	[845]	TGETS	  2	2	3	; slot2 = uv0"log".error
		 15	[845]	KSTR 	  3		2	; slot3 = "Not implemented for tsv format"
		 16	[845]	CALL 	  2	1	2	;  = uv0"log".error(slot3)
		 17	[846]	KPRI 	  2		0	; slot2 = nil
		 18	[846]	RET1 	  2		2	; return slot2
		 19	[846]	JMP  	  2		4	; 	goto 24
		 20	[848]	TGETS	  2	0	1	; slot2 = self.db
		 21	[848]	TGETS	  2	2	0	; slot2 = self.db.groups
		 22	[848]	TGETV	  2	2	1	; slot2 = self.db.groups[i]
		 23	[848]	RET1 	  2		2	; return slot2
		 24	[850]	RET0 	  0		1	; return
	216	[841]	TSETS	 14	5	25	; wave_db.get_group = slot14
	217	[858]	FNEW 	 14		22	; @./all/wave_db.lua:852-858: 3 args, 0 upvalues, 5 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-24:	self
		  0-24:	pi
		  0-24:	spi
		;;;; instructions ;;;;
		  1	[853]	TGETS	  3	0	1	; slot3 = self.db
		  2	[853]	ISF  	   		3	; if not self.db
		  3	[853]	JMP  	  4		18	; 	goto 22
		  4	[853]	TGETS	  3	0	1	; slot3 = self.db
		  5	[853]	TGETS	  3	3	0	; slot3 = self.db.flags_visibility
		  6	[853]	ISF  	   		3	; if not self.db.flags_visibility
		  7	[853]	JMP  	  4		14	; 	goto 22
		  8	[853]	TGETS	  3	0	1	; slot3 = self.db
		  9	[853]	TGETS	  3	3	0	; slot3 = self.db.flags_visibility
		 10	[853]	TGETV	  3	3	1	; slot3 = self.db.flags_visibility[pi]
		 11	[853]	ISF  	   		3	; if not slot3
		 12	[853]	JMP  	  4		9	; 	goto 22
		 13	[854]	TGETS	  3	0	1	; slot3 = self.db
		 14	[854]	TGETS	  3	3	0	; slot3 = self.db.flags_visibility
		 15	[854]	TGETV	  3	3	1	; slot3 = self.db.flags_visibility[pi]
		 16	[854]	ISTC 	  4		2	; slot4 = spi; if spi
		 17	[854]	JMP  	  4		1	; 	goto 19
		 18	[854]	KSHORT	  4		1	; slot4 = 1
		 19	[854]	TGETV	  3	3	4	; slot3 = slot3[slot4]
		 20	[854]	RET1 	  3		2	; return slot3
		 21	[854]	JMP  	  3		2	; 	goto 24
		 22	[856]	KPRI 	  3		2	; slot3 = true
		 23	[856]	RET1 	  3		2	; return slot3
		 24	[858]	RET0 	  0		1	; return
	218	[852]	TSETS	 14	5	23	; wave_db.is_flag_visible = slot14
	219	[873]	FNEW 	 14		20	; @./all/wave_db.lua:864-873: 2 args, 1 upvalues, 4 slots
		
		;;;; constant tables ;;;;
		ktable#3 = [
			[repeat_count] = 0,
			[current_idx] = 0,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	WS_IDLE
		;;;; variable info ;;;;
		  0-7:	self
		  0-7:	wave_name
		  4-7:	ws
		;;;; instructions ;;;;
		  1	[865]	TDUP 	  2		3	; slot2 = copy table#k3
		  2	[866]	UGET 	  3		0	; slot3 = uv0"WS_IDLE"
		  3	[866]	TSETS	  3	2	2	; slot2.state = uv0"WS_IDLE"
		  4	[869]	TSETS	  1	2	1	; slot2.name = wave_name
		  5	[871]	TGETS	  3	0	0	; slot3 = self.db_waves_status
		  6	[871]	TSETV	  2	3	1	; self.db_waves_status[wave_name] = ws
		  7	[872]	RET1 	  2		2	; return ws
	220	[864]	TSETS	 14	5	21	; wave_db.create_wave_status = slot14
	221	[878]	FNEW 	 14		18	; @./all/wave_db.lua:875-878: 2 args, 0 upvalues, 3 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-6:	self
		  0-6:	wave_name
		;;;; instructions ;;;;
		  1	[876]	IST  	   		1	; if wave_name
		  2	[876]	JMP  	  2		1	; 	goto 4
		  3	[876]	KSTR 	  1		1	; slot1 = "main"
		  4	[877]	TGETS	  2	0	0	; slot2 = self.db_waves_status
		  5	[877]	TGETV	  2	2	1	; slot2 = self.db_waves_status[wave_name]
		  6	[877]	RET1 	  2		2	; return slot2
	222	[875]	TSETS	 14	5	19	; wave_db.get_wave_status = slot14
	223	[900]	FNEW 	 14		16	; @./all/wave_db.lua:885-900: 2 args, 4 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	WS_PENDING
		  2:	WS_RUNNING
		  3:	WS_DONE
		;;;; variable info ;;;;
		  0-44:	self
		  0-44:	wave_name
		  15-44:	s
		;;;; instructions ;;;;
		  1	[886]	ISF  	   		1	; if not wave_name
		  2	[886]	JMP  	  2		4	; 	goto 7
		  3	[886]	ISEQS	  1		9	; if wave_name == "main"
		  4	[886]	JMP  	  2		2	; 	goto 7
		  5	[886]	ISNES	  1		8	; if wave_name ~= ""
		  6	[886]	JMP  	  2		5	; 	goto 12
		  7	[887]	UGET 	  2		0	; slot2 = uv0"log"
		  8	[887]	TGETS	  2	2	7	; slot2 = uv0"log".error
		  9	[887]	KSTR 	  3		6	; slot3 = "cannot stop main waves"
		 10	[887]	CALL 	  2	1	2	;  = uv0"log".error(slot3)
		 11	[888]	RET0 	  0		1	; return
		 12	[890]	MOV  	  3		0	; slot3 = self
		 13	[890]	TGETS	  2	0	5	; slot2 = self.get_wave_status
		 14	[890]	MOV  	  4		1	; slot4 = wave_name
		 15	[890]	CALL 	  2	2	3	; slot2 = self.get_wave_status(self, wave_name)
		 16	[891]	IST  	   		2	; if s
		 17	[891]	JMP  	  3		6	; 	goto 24
		 18	[892]	UGET 	  3		0	; slot3 = uv0"log"
		 19	[892]	TGETS	  3	3	7	; slot3 = uv0"log".error
		 20	[892]	KSTR 	  4		4	; slot4 = "manual wave %s does not exist"
		 21	[892]	MOV  	  5		1	; slot5 = wave_name
		 22	[892]	CALL 	  3	1	3	;  = uv0"log".error(slot4, wave_name)
		 23	[893]	RET0 	  0		1	; return
		 24	[895]	GGET 	  3		3	; slot3 = _env["table"]
		 25	[895]	TGETS	  3	3	2	; slot3 = table.contains
		 26	[895]	TNEW 	  4		3	; slot4 = new table( array: 3, dict: 1)
		 27	[895]	UGET 	  5		1	; slot5 = uv1"WS_PENDING"
		 28	[895]	TSETB	  5	4	1	; slot4[1] = uv1"WS_PENDING"
		 29	[895]	UGET 	  5		2	; slot5 = uv2"WS_RUNNING"
		 30	[895]	TSETB	  5	4	2	; slot4[2] = uv2"WS_RUNNING"
		 31	[895]	TGETS	  5	2	1	; slot5 = s.state
		 32	[895]	CALL 	  3	2	3	; slot3 = table.contains(slot4, s.state)
		 33	[895]	ISF  	   		3	; if not slot3
		 34	[895]	JMP  	  4		3	; 	goto 38
		 35	[896]	UGET 	  3		3	; slot3 = uv3"WS_DONE"
		 36	[896]	TSETS	  3	2	1	; s.state = uv3"WS_DONE"
		 37	[896]	JMP  	  3		6	; 	goto 44
		 38	[898]	UGET 	  3		0	; slot3 = uv0"log"
		 39	[898]	TGETS	  3	3	7	; slot3 = uv0"log".error
		 40	[898]	KSTR 	  4		0	; slot4 = "manual wave %s cannot be stopped in state %s"
		 41	[898]	MOV  	  5		1	; slot5 = wave_name
		 42	[898]	TGETS	  6	2	1	; slot6 = s.state
		 43	[898]	CALL 	  3	1	4	;  = uv0"log".error(slot4, wave_name, s.state)
		 44	[900]	RET0 	  0		1	; return
	224	[885]	TSETS	 14	5	17	; wave_db.stop_manual_wave = slot14
	225	[919]	FNEW 	 14		14	; @./all/wave_db.lua:902-919: 2 args, 4 upvalues, 6 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	WS_PENDING
		  2:	WS_RUNNING
		  3:	WS_DONE
		;;;; variable info ;;;;
		  0-49:	self
		  0-49:	wave_name
		  15-49:	s
		;;;; instructions ;;;;
		  1	[903]	ISF  	   		1	; if not wave_name
		  2	[903]	JMP  	  2		4	; 	goto 7
		  3	[903]	ISEQS	  1		13	; if wave_name == "main"
		  4	[903]	JMP  	  2		2	; 	goto 7
		  5	[903]	ISNES	  1		12	; if wave_name ~= ""
		  6	[903]	JMP  	  2		5	; 	goto 12
		  7	[904]	UGET 	  2		0	; slot2 = uv0"log"
		  8	[904]	TGETS	  2	2	11	; slot2 = uv0"log".error
		  9	[904]	KSTR 	  3		10	; slot3 = "cannot start main waves"
		 10	[904]	CALL 	  2	1	2	;  = uv0"log".error(slot3)
		 11	[905]	RET0 	  0		1	; return
		 12	[907]	MOV  	  3		0	; slot3 = self
		 13	[907]	TGETS	  2	0	9	; slot2 = self.get_wave_status
		 14	[907]	MOV  	  4		1	; slot4 = wave_name
		 15	[907]	CALL 	  2	2	3	; slot2 = self.get_wave_status(self, wave_name)
		 16	[908]	IST  	   		2	; if s
		 17	[908]	JMP  	  3		6	; 	goto 24
		 18	[909]	UGET 	  3		0	; slot3 = uv0"log"
		 19	[909]	TGETS	  3	3	11	; slot3 = uv0"log".error
		 20	[909]	KSTR 	  4		8	; slot4 = "manual wave %s does not exist"
		 21	[909]	MOV  	  5		1	; slot5 = wave_name
		 22	[909]	CALL 	  3	1	3	;  = uv0"log".error(slot4, wave_name)
		 23	[910]	RET0 	  0		1	; return
		 24	[912]	GGET 	  3		7	; slot3 = _env["table"]
		 25	[912]	TGETS	  3	3	6	; slot3 = table.contains
		 26	[912]	TNEW 	  4		4	; slot4 = new table( array: 4, dict: 1)
		 27	[912]	UGET 	  5		1	; slot5 = uv1"WS_PENDING"
		 28	[912]	TSETB	  5	4	1	; slot4[1] = uv1"WS_PENDING"
		 29	[912]	UGET 	  5		2	; slot5 = uv2"WS_RUNNING"
		 30	[912]	TSETB	  5	4	2	; slot4[2] = uv2"WS_RUNNING"
		 31	[912]	UGET 	  5		3	; slot5 = uv3"WS_DONE"
		 32	[912]	TSETB	  5	4	3	; slot4[3] = uv3"WS_DONE"
		 33	[912]	TGETS	  5	2	5	; slot5 = s.state
		 34	[912]	CALL 	  3	2	3	; slot3 = table.contains(slot4, s.state)
		 35	[912]	ISF  	   		3	; if not slot3
		 36	[912]	JMP  	  4		6	; 	goto 43
		 37	[913]	UGET 	  3		0	; slot3 = uv0"log"
		 38	[913]	TGETS	  3	3	11	; slot3 = uv0"log".error
		 39	[913]	KSTR 	  4		4	; slot4 = "manual wave %s pending or still running. cannot have more than one at a time."
		 40	[913]	MOV  	  5		1	; slot5 = wave_name
		 41	[913]	CALL 	  3	1	3	;  = uv0"log".error(slot4, wave_name)
		 42	[914]	RET0 	  0		1	; return
		 43	[916]	UGET 	  3		1	; slot3 = uv1"WS_PENDING"
		 44	[916]	TSETS	  3	2	5	; s.state = uv1"WS_PENDING"
		 45	[917]	TGETS	  3	2	2	; slot3 = s.first_idx
		 46	[917]	TSETS	  3	2	3	; s.current_idx = s.first_idx
		 47	[918]	TGETS	  3	2	0	; slot3 = s.repeat_count
		 48	[918]	TSETS	  3	2	1	; s.repeat_remaining = s.repeat_count
		 49	[919]	RET0 	  0		1	; return
	226	[902]	TSETS	 14	5	15	; wave_db.start_manual_wave = slot14
	227	[927]	FNEW 	 14		12	; @./all/wave_db.lua:921-927: 1 args, 1 upvalues, 8 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	WS_PENDING
		;;;; variable info ;;;;
		  0-15:	self
		  3-14:	<generator>
		  3-14:	<state>
		  3-14:	<control>
		  4-12:	k
		  4-12:	v
		;;;; instructions ;;;;
		  1	[922]	GGET 	  1		3	; slot1 = _env["pairs"]
		  2	[922]	TGETS	  2	0	2	; slot2 = self.db_waves_status
		  3	[922]	CALL 	  1	4	2	; slot1, slot2, slot3 = pairs(self.db_waves_status)
		  4	[922]	ISNEXT	  4		8	; Verify ITERN at 13; goto 13
		  5	[923]	ISEQS	  4		1	; if k == "main"
		  6	[923]	JMP  	  6		6	; 	goto 13
		  7	[923]	TGETS	  6	5	0	; slot6 = v.state
		  8	[923]	UGET 	  7		0	; slot7 = uv0"WS_PENDING"
		  9	[923]	ISNEV	  6		7	; if v.state ~= uv0"WS_PENDING"
		 10	[923]	JMP  	  6		2	; 	goto 13
		 11	[924]	KPRI 	  6		2	; slot6 = true
		 12	[924]	RET1 	  6		2	; return slot6
		 13	[922]	ITERN	  4	3	3	; slot4, slot5, slot6 = slot1<generator>, slot2<state>, slot3<control>; slot4, slot5 = slot1<generator>(slot2<state>, slot3<control>)
		 14	[922]	ITERL	  4		-10	; slot3<control> = slot4; if slot4 != nil goto 5
		 15	[927]	RET0 	  0		1	; return
	228	[921]	TSETS	 14	5	13	; wave_db.has_pending_manual_waves = slot14
	229	[937]	FNEW 	 14		10	; @./all/wave_db.lua:929-937: 1 args, 1 upvalues, 10 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	WS_PENDING
		;;;; variable info ;;;;
		  0-17:	self
		  1-17:	names
		  4-16:	<generator>
		  4-16:	<state>
		  4-16:	<control>
		  5-14:	k
		  5-14:	v
		;;;; instructions ;;;;
		  1	[930]	TNEW 	  1		0	; slot1 = new table( array: 0, dict: 1)
		  2	[931]	GGET 	  2		4	; slot2 = _env["pairs"]
		  3	[931]	TGETS	  3	0	3	; slot3 = self.db_waves_status
		  4	[931]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(self.db_waves_status)
		  5	[931]	ISNEXT	  5		9	; Verify ITERN at 15; goto 15
		  6	[932]	TGETS	  7	6	2	; slot7 = v.state
		  7	[932]	UGET 	  8		0	; slot8 = uv0"WS_PENDING"
		  8	[932]	ISNEV	  7		8	; if v.state ~= uv0"WS_PENDING"
		  9	[932]	JMP  	  7		5	; 	goto 15
		 10	[933]	GGET 	  7		1	; slot7 = _env["table"]
		 11	[933]	TGETS	  7	7	0	; slot7 = table.insert
		 12	[933]	MOV  	  8		1	; slot8 = names
		 13	[933]	MOV  	  9		5	; slot9 = k
		 14	[933]	CALL 	  7	1	3	;  = table.insert(names, k)
		 15	[931]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		 16	[931]	ITERL	  5		-11	; slot4<control> = slot5; if slot5 != nil goto 6
		 17	[936]	RET1 	  1		2	; return names
	230	[929]	TSETS	 14	5	11	; wave_db.list_pending_manual_waves = slot14
	231	[949]	FNEW 	 14		8	; @./all/wave_db.lua:943-949: 1 args, 0 upvalues, 2 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-14:	self
		;;;; instructions ;;;;
		  1	[944]	TGETS	  1	0	1	; slot1 = self.db
		  2	[944]	ISF  	   		1	; if not self.db
		  3	[944]	JMP  	  2		8	; 	goto 12
		  4	[944]	TGETS	  1	0	1	; slot1 = self.db
		  5	[944]	TGETS	  1	1	0	; slot1 = self.db.nextWaveRewardMoneyMultiplier
		  6	[944]	ISF  	   		1	; if not self.db.nextWaveRewardMoneyMultiplier
		  7	[944]	JMP  	  2		4	; 	goto 12
		  8	[945]	TGETS	  1	0	1	; slot1 = self.db
		  9	[945]	TGETS	  1	1	0	; slot1 = self.db.nextWaveRewardMoneyMultiplier
		 10	[945]	RET1 	  1		2	; return self.db.nextWaveRewardMoneyMultiplier
		 11	[945]	JMP  	  1		2	; 	goto 14
		 12	[947]	KSHORT	  1		1	; slot1 = 1
		 13	[947]	RET1 	  1		2	; return slot1
		 14	[949]	RET0 	  0		1	; return
	232	[943]	TSETS	 14	5	9	; wave_db.get_endless_early_wave_reward_factor = slot14
	233	[957]	FNEW 	 14		6	; @./all/wave_db.lua:951-957: 1 args, 0 upvalues, 3 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-16:	self
		;;;; instructions ;;;;
		  1	[952]	TGETS	  1	0	3	; slot1 = self.db
		  2	[952]	ISF  	   		1	; if not self.db
		  3	[952]	JMP  	  2		10	; 	goto 14
		  4	[952]	TGETS	  1	0	3	; slot1 = self.db
		  5	[952]	TGETS	  1	1	2	; slot1 = self.db.score
		  6	[952]	ISF  	   		1	; if not self.db.score
		  7	[952]	JMP  	  2		6	; 	goto 14
		  8	[953]	GGET 	  1		1	; slot1 = _env["table"]
		  9	[953]	TGETS	  1	1	0	; slot1 = table.deepclone
		 10	[953]	TGETS	  2	0	3	; slot2 = self.db
		 11	[953]	TGETS	  2	2	2	; slot2 = self.db.score
		 12	[953]	CALLT	  1		2	; return table.deepclone(self.db.score)
		 13	[953]	JMP  	  1		2	; 	goto 16
		 14	[955]	KPRI 	  1		0	; slot1 = nil
		 15	[955]	RET1 	  1		2	; return slot1
		 16	[957]	RET0 	  0		1	; return
	234	[951]	TSETS	 14	5	7	; wave_db.get_endless_score_config = slot14
	235	[980]	FNEW 	 14		4	; @./all/wave_db.lua:959-980: 2 args, 1 upvalues, 12 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	km
		;;;; variable info ;;;;
		  0-39:	self
		  0-39:	i
		  1-39:	out
		  2-39:	db
		  4-39:	dif_max
		  8-39:	dif_level
		  14-39:	dif_idx
		  16-39:	dif
		  17-39:	dbc
		;;;; instructions ;;;;
		  1	[960]	TNEW 	  2		0	; slot2 = new table( array: 0, dict: 1)
		  2	[962]	TGETS	  3	0	20	; slot3 = self.db
		  3	[963]	TGETS	  4	3	19	; slot4 = db.difficulties
		  4	[963]	LEN  	  4		4	; slot4 = #db.difficulties
		  5	[964]	GGET 	  5		18	; slot5 = _env["math"]
		  6	[964]	TGETS	  5	5	17	; slot5 = math.ceil
		  7	[964]	DIVVN	  6	1	0	; slot6 = i / 10
		  8	[964]	CALL 	  5	2	2	; slot5 = math.ceil(slot6)
		  9	[965]	UGET 	  6		0	; slot6 = uv0"km"
		 10	[965]	TGETS	  6	6	16	; slot6 = uv0"km".clamp
		 11	[965]	KSHORT	  7		1	; slot7 = 1
		 12	[965]	MOV  	  8		4	; slot8 = dif_max
		 13	[965]	MOV  	  9		5	; slot9 = dif_level
		 14	[965]	CALL 	  6	2	4	; slot6 = uv0"km".clamp(slot7, dif_max, dif_level)
		 15	[966]	TGETS	  7	3	19	; slot7 = db.difficulties
		 16	[966]	TGETV	  7	7	6	; slot7 = db.difficulties[dif_idx]
		 17	[967]	TGETS	  8	7	15	; slot8 = dif.bossConfig
		 18	[970]	TGETS	  9	8	13	; slot9 = dbc.powerChance
		 19	[970]	TGETS	 10	8	12	; slot10 = dbc.powerChanceIncrement
		 20	[970]	MULVV	 10	10	5	; slot10 = dbc.powerChanceIncrement * dif_level
		 21	[970]	ADDVV	  9	9	10	; slot9 = dbc.powerChance + slot10
		 22	[970]	TSETS	  9	2	14	; out.chance = slot9
		 23	[971]	GGET 	  9		18	; slot9 = _env["math"]
		 24	[971]	TGETS	  9	9	10	; slot9 = math.random
		 25	[971]	TGETS	 10	8	9	; slot10 = dbc.powerCooldownMin
		 26	[971]	TGETS	 11	8	8	; slot11 = dbc.powerCooldownMax
		 27	[971]	CALL 	  9	2	3	; slot9 = math.random(dbc.powerCooldownMin, dbc.powerCooldownMax)
		 28	[971]	TSETS	  9	2	11	; out.cooldown = math.random
		 29	[972]	TGETS	  9	8	6	; slot9 = dbc.powerMultiChance
		 30	[972]	TSETS	  9	2	7	; out.multiple_attacks_chance = dbc.powerMultiChance
		 31	[973]	TGETS	  9	8	4	; slot9 = dbc.powerDistribution
		 32	[973]	TSETS	  9	2	5	; out.power_chances = dbc.powerDistribution
		 33	[974]	TGETS	  9	8	2	; slot9 = dbc.powerConfig
		 34	[974]	TSETS	  9	2	3	; out.powers_config_dif = dbc.powerConfig
		 35	[975]	TSETS	  8	2	1	; out.boss_config_dif = dbc
		 36	[977]	TGETS	  9	3	15	; slot9 = db.bossConfig
		 37	[977]	TGETS	  9	9	2	; slot9 = db.bossConfig.powerConfig
		 38	[977]	TSETS	  9	2	0	; out.powers_config = db.bossConfig.powerConfig
		 39	[979]	RET1 	  2		2	; return out
	236	[959]	TSETS	 14	5	5	; wave_db.get_endless_boss_config = slot14
	237	[1093]	FNEW 	 14		2	; @./all/wave_db.lua:982-1093: 2 args, 3 upvalues, 44 slots
		
		;;;; constant tables ;;;;
		ktable#22 = [
			]
		
		
		ktable#25 = [
			[delay] = 0,
			]
		
		
		ktable#37 = [
			]
		
		
		ktable#55 = [
			[dif_idx] = 1,
			[next_dif_uses] = 0,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	km
		  1:	log
		  2:	E
		;;;; variable info ;;;;
		  0-284:	self
		  0-284:	i
		  1-284:	db
		  11-284:	paths_order
		  17-29:	<generator>
		  17-29:	<state>
		  17-29:	<control>
		  18-27:	_
		  18-27:	v
		  22-27:	rv
		  22-27:	rvi
		  30-284:	waves_per_load
		  32-284:	used_waves
		  34-284:	dif_idx
		  36-284:	dif_max
		  38-284:	dif
		  46-284:	dif_next
		  47-284:	max_paths
		  54-284:	boss_waves_count
		  63-284:	multipath_chance
		  64-284:	next_dif_chances
		  66-284:	next_dif_uses
		  69-284:	o_group
		  70-284:	wave_interval
		  73-247:	<index>
		  73-247:	<limit>
		  73-247:	<step>
		  74-246:	pi
		  90-246:	cycle_index
		  91-246:	waves
		  104-129:	next_dif_chance
		  134-246:	candidate_waves
		  143-246:	wave
		  157-246:	o_wave
		  158-246:	has_some_flying
		  161-233:	<generator>
		  161-233:	<state>
		  161-233:	<control>
		  162-231:	_
		  162-231:	spawn
		  198-231:	o_spawn
		  208-231:	tpl
		;;;; instructions ;;;;
		  1	[983]	TGETS	  2	0	57	; slot2 = self.db
		  2	[984]	TGETS	  3	2	56	; slot3 = db.vars
		  3	[984]	IST  	   		3	; if db.vars
		  4	[984]	JMP  	  3		6	; 	goto 11
		  5	[985]	TDUP 	  3		55	; slot3 = copy table#k55
		  6	[988]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
		  7	[988]	TSETS	  4	3	54	; slot3.used_waves = slot4
		  8	[989]	TNEW 	  4		0	; slot4 = new table( array: 0, dict: 1)
		  9	[989]	TSETS	  4	3	53	; slot3.first_entity_wave = slot4
		 10	[990]	TSETS	  3	2	56	; db.vars = slot3
		 11	[994]	TNEW 	  3		0	; slot3 = new table( array: 0, dict: 1)
		 12	[995]	GGET 	  4		52	; slot4 = _env["pairs"]
		 13	[995]	GGET 	  5		51	; slot5 = _env["table"]
		 14	[995]	TGETS	  5	5	50	; slot5 = table.random_order
		 15	[995]	TGETS	  6	2	49	; slot6 = db.pathConfig
		 16	[995]	CALL 	  5	0	2	; MULTRES = table.random_order(db.pathConfig)
		 17	[995]	CALLM	  4	4	0	; slot4, slot5, slot6 = pairs(, ...MULTRES)
		 18	[995]	ISNEXT	  7		9	; Verify ITERN at 28; goto 28
		 19	[996]	GGET 	  9		51	; slot9 = _env["table"]
		 20	[996]	TGETS	  9	9	48	; slot9 = table.random
		 21	[996]	MOV  	 10		8	; slot10 = v
		 22	[996]	CALL 	  9	3	2	; slot9, slot10 = table.random(v)
		 23	[997]	GGET 	 11		51	; slot11 = _env["table"]
		 24	[997]	TGETS	 11	11	47	; slot11 = table.insert
		 25	[997]	MOV  	 12		3	; slot12 = paths_order
		 26	[997]	ADDVN	 13	9	0	; slot13 = rv + 1
		 27	[997]	CALL 	 11	1	3	;  = table.insert(paths_order, slot13)
		 28	[995]	ITERN	  7	3	3	; slot7, slot8, slot9 = slot4<generator>, slot5<state>, slot6<control>; slot7, slot8 = slot4<generator>(slot5<state>, slot6<control>)
		 29	[995]	ITERL	  7		-11	; slot6<control> = slot7; if slot7 != nil goto 19
		 30	[1000]	KSHORT	  4		10	; slot4 = 10
		 31	[1001]	TGETS	  5	2	56	; slot5 = db.vars
		 32	[1001]	TGETS	  5	5	54	; slot5 = db.vars.used_waves
		 33	[1002]	TGETS	  6	2	56	; slot6 = db.vars
		 34	[1002]	TGETS	  6	6	46	; slot6 = db.vars.dif_idx
		 35	[1003]	TGETS	  7	2	45	; slot7 = db.difficulties
		 36	[1003]	LEN  	  7		7	; slot7 = #db.difficulties
		 37	[1004]	TGETS	  8	2	45	; slot8 = db.difficulties
		 38	[1004]	TGETV	  8	8	6	; slot8 = db.difficulties[dif_idx]
		 39	[1005]	TGETS	  9	2	45	; slot9 = db.difficulties
		 40	[1005]	UGET 	 10		0	; slot10 = uv0"km"
		 41	[1005]	TGETS	 10	10	44	; slot10 = uv0"km".clamp
		 42	[1005]	KSHORT	 11		1	; slot11 = 1
		 43	[1005]	MOV  	 12		7	; slot12 = dif_max
		 44	[1005]	ADDVN	 13	6	0	; slot13 = dif_idx + 1
		 45	[1005]	CALL 	 10	2	4	; slot10 = uv0"km".clamp(slot11, dif_max, slot13)
		 46	[1005]	TGETV	  9	9	10	; slot9 = db.difficulties[uv0"km".clamp]
		 47	[1006]	TGETS	 10	8	43	; slot10 = dif.max_paths
		 48	[1007]	MODVV	 11	1	4	; slot11 = i % waves_per_load
		 49	[1007]	ISEQN	 11		1	; if slot11 == 0
		 50	[1007]	JMP  	 11		2	; 	goto 53
		 51	[1007]	KSHORT	 11		0	; slot11 = 0
		 52	[1007]	JMP  	 12		2	; 	goto 55
		 53	[1007]	TGETS	 11	8	42	; slot11 = dif.bossWaves
		 54	[1007]	LEN  	 11		11	; slot11 = #dif.bossWaves
		 55	[1008]	ISNEN	  1		0	; if i ~= 1
		 56	[1008]	JMP  	 12		2	; 	goto 59
		 57	[1008]	KSHORT	 12		0	; slot12 = 0
		 58	[1008]	JMP  	 13		5	; 	goto 64
		 59	[1008]	TGETS	 12	8	41	; slot12 = dif.multiple_paths_chance
		 60	[1008]	TGETS	 13	8	40	; slot13 = dif.multiple_paths_chance_increment
		 61	[1008]	MULVV	 13	13	1	; slot13 = dif.multiple_paths_chance_increment * i
		 62	[1008]	ADDVV	 12	12	13	; slot12 = dif.multiple_paths_chance + slot13
		 63	[1008]	DIVVN	 12	12	2	; slot12 = slot12 / 100
		 64	[1009]	TGETS	 13	2	39	; slot13 = db.chancesToUseNextDifficulty
		 65	[1010]	TGETS	 14	2	56	; slot14 = db.vars
		 66	[1010]	TGETS	 14	14	38	; slot14 = db.vars.next_dif_uses
		 67	[1012]	TDUP 	 15		37	; slot15 = copy table#k37
		 68	[1012]	TNEW 	 16		0	; slot16 = new table( array: 0, dict: 1)
		 69	[1012]	TSETS	 16	15	36	; slot15.waves = slot16
		 70	[1013]	KSHORT	 16		0	; slot16 = 0
		 71	[1015]	KSHORT	 17		1	; slot17 = 1
		 72	[1015]	MOV  	 18		10	; slot18 = max_paths
		 73	[1015]	KSHORT	 19		1	; slot19 = 1
		 74	[1015]	FORI 	 17		173	; for slot20 = slot17,slot18,slot19 else goto 248
		 75	[1016]	KSHORT	 21		1	; slot21 = 1
		 76	[1016]	ISGE 	 21		20	; if slot21 >= pi
		 77	[1016]	JMP  	 21		8	; 	goto 86
		 78	[1016]	ISNEN	 11		1	; if boss_waves_count ~= 0
		 79	[1016]	JMP  	 21		6	; 	goto 86
		 80	[1016]	GGET 	 21		35	; slot21 = _env["math"]
		 81	[1016]	TGETS	 21	21	48	; slot21 = math.random
		 82	[1016]	CALL 	 21	2	1	; slot21 = math.random()
		 83	[1016]	ISGE 	 12		21	; if multipath_chance >= math.random
		 84	[1016]	JMP  	 21		1	; 	goto 86
		 85	[1017]	JMP  	 21		161	; 	goto 247
		 86	[1020]	UGET 	 21		0	; slot21 = uv0"km"
		 87	[1020]	TGETS	 21	21	34	; slot21 = uv0"km".zmod
		 88	[1020]	MOV  	 22		1	; slot22 = i
		 89	[1020]	MOV  	 23		4	; slot23 = waves_per_load
		 90	[1020]	CALL 	 21	2	3	; slot21 = uv0"km".zmod(i, waves_per_load)
		 91	[1023]	KPRI 	 22		0	; slot22 = nil
		 92	[1024]	KSHORT	 23		0	; slot23 = 0
		 93	[1024]	ISGE 	 23		11	; if slot23 >= boss_waves_count
		 94	[1024]	JMP  	 23		3	; 	goto 98
		 95	[1025]	TGETS	 22	8	42	; slot22 = dif.bossWaves
		 96	[1026]	SUBVN	 11	11	0	; slot11 = boss_waves_count - 1
		 97	[1026]	JMP  	 23		32	; 	goto 130
		 98	[1028]	SUBVV	 23	21	4	; slot23 = cycle_index - waves_per_load
		 99	[1028]	LEN  	 24		13	; slot24 = #next_dif_chances
		100	[1028]	ADDVV	 23	23	24	; slot23 = slot23 + slot24
		101	[1028]	TGETV	 23	13	23	; slot23 = next_dif_chances[slot23]
		102	[1028]	IST  	   		23	; if slot23
		103	[1028]	JMP  	 24		1	; 	goto 105
		104	[1028]	KSHORT	 23		0	; slot23 = 0
		105	[1029]	GGET 	 24		35	; slot24 = _env["math"]
		106	[1029]	TGETS	 24	24	33	; slot24 = math.pow
		107	[1029]	KNUM 	 25		3	; slot25 = 0.5
		108	[1029]	MOV  	 26		14	; slot26 = next_dif_uses
		109	[1029]	CALL 	 24	2	3	; slot24 = math.pow(slot25, next_dif_uses)
		110	[1029]	MULVV	 23	23	24	; slot23 = next_dif_chance * math.pow
		111	[1030]	UGET 	 24		1	; slot24 = uv1"log"
		112	[1030]	TGETS	 24	24	32	; slot24 = uv1"log".paranoid
		113	[1030]	KSTR 	 25		31	; slot25 = "  ENDLESS NORMAL WAVE. next_dif_chance:%s next_dif_uses:%s  chances:%s"
		114	[1030]	MOV  	 26		23	; slot26 = next_dif_chance
		115	[1030]	MOV  	 27		14	; slot27 = next_dif_uses
		116	[1030]	GGET 	 28		30	; slot28 = _env["getfulldump"]
		117	[1030]	MOV  	 29		13	; slot29 = next_dif_chances
		118	[1030]	CALL 	 28	0	2	; MULTRES = getfulldump(next_dif_chances)
		119	[1030]	CALLM	 24	1	3	;  = uv1"log".paranoid(slot25, next_dif_chance, next_dif_uses, ...MULTRES)
		120	[1031]	GGET 	 24		35	; slot24 = _env["math"]
		121	[1031]	TGETS	 24	24	48	; slot24 = math.random
		122	[1031]	CALL 	 24	2	1	; slot24 = math.random()
		123	[1031]	ISGE 	 24		23	; if math.random >= next_dif_chance
		124	[1031]	JMP  	 24		4	; 	goto 129
		125	[1032]	ADDVN	 14	14	0	; slot14 = next_dif_uses + 1
		126	[1033]	TGETS	 22	9	36	; slot22 = dif_next.waves
		127	[1034]	KSHORT	 21		1	; slot21 = 1
		128	[1034]	JMP  	 24		1	; 	goto 130
		129	[1036]	TGETS	 22	8	36	; slot22 = dif.waves
		130	[1041]	GGET 	 23		51	; slot23 = _env["table"]
		131	[1041]	TGETS	 23	23	29	; slot23 = table.filter
		132	[1041]	MOV  	 24		22	; slot24 = waves
		133	[1041]	FNEW 	 25		28	; @./all/wave_db.lua:1041-1041: 2 args, 1 upvalues, 5 slots
			
			;;;; constant tables ;;;;
			;;;; instructions ;;;;
			  1	[1041]	GGET 	  2		1	; slot2 = _env["table"]
			  2	[1041]	TGETS	  2	2	0	; slot2 = table.contains
			  3	[1041]	UGET 	  3		0	; slot3 = uv0"used_waves"
			  4	[1041]	MOV  	  4		1	; slot4 = v
			  5	[1041]	CALL 	  2	2	3	; slot2 = table.contains(uv0"used_waves", v)
			  6	[1041]	NOT  	  2		2	; slot2 = not slot2
			  7	[1041]	RET1 	  2		2	; return slot2
		134	[1041]	CALL 	 23	2	3	; slot23 = table.filter(waves, slot25)
		135	[1042]	LEN  	 24		23	; slot24 = #candidate_waves
		136	[1042]	ISNEN	 24		1	; if slot24 ~= 0
		137	[1042]	JMP  	 24		2	; 	goto 140
		138	[1043]	MOV  	 23		22	; slot23 = waves
		139	[1044]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		140	[1046]	GGET 	 24		51	; slot24 = _env["table"]
		141	[1046]	TGETS	 24	24	48	; slot24 = table.random
		142	[1046]	MOV  	 25		23	; slot25 = candidate_waves
		143	[1046]	CALL 	 24	2	2	; slot24 = table.random(candidate_waves)
		144	[1047]	GGET 	 25		51	; slot25 = _env["table"]
		145	[1047]	TGETS	 25	25	47	; slot25 = table.insert
		146	[1047]	MOV  	 26		5	; slot26 = used_waves
		147	[1047]	MOV  	 27		24	; slot27 = wave
		148	[1047]	CALL 	 25	1	3	;  = table.insert(used_waves, wave)
		149	[1048]	GGET 	 25		35	; slot25 = _env["math"]
		150	[1048]	TGETS	 25	25	27	; slot25 = math.max
		151	[1048]	MOV  	 26		16	; slot26 = wave_interval
		152	[1048]	TGETS	 27	24	26	; slot27 = wave.next_wave_interval
		153	[1048]	CALL 	 25	2	3	; slot25 = math.max(wave_interval, wave.next_wave_interval)
		154	[1048]	MOV  	 16		25	; slot16 = math.max
		155	[1050]	TDUP 	 25		25	; slot25 = copy table#k25
		156	[1050]	TNEW 	 26		0	; slot26 = new table( array: 0, dict: 1)
		157	[1050]	TSETS	 26	25	24	; slot25.spawns = slot26
		158	[1051]	KPRI 	 26		1	; slot26 = false
		159	[1052]	GGET 	 27		52	; slot27 = _env["pairs"]
		160	[1052]	TGETS	 28	24	24	; slot28 = wave.spawns
		161	[1052]	CALL 	 27	4	2	; slot27, slot28, slot29 = pairs(wave.spawns)
		162	[1052]	ISNEXT	 30		69	; Verify ITERN at 232; goto 232
		163	[1053]	TDUP 	 32		22	; slot32 = copy table#k22
		164	[1054]	TGETS	 33	31	23	; slot33 = spawn.creep
		165	[1054]	TSETS	 33	32	23	; slot32.creep = spawn.creep
		166	[1055]	TGETS	 33	31	21	; slot33 = spawn.creep_aux
		167	[1055]	TSETS	 33	32	21	; slot32.creep_aux = spawn.creep_aux
		168	[1056]	TGETS	 33	31	20	; slot33 = spawn.max_same
		169	[1056]	TSETS	 33	32	20	; slot32.max_same = spawn.max_same
		170	[1057]	TGETS	 33	31	19	; slot33 = spawn.cant
		171	[1057]	TGETS	 34	31	18	; slot34 = spawn.cant_cicle
		172	[1057]	ISNEN	 34		1	; if spawn.cant_cicle ~= 0
		173	[1057]	JMP  	 34		2	; 	goto 176
		174	[1057]	KSHORT	 34		0	; slot34 = 0
		175	[1057]	JMP  	 35		12	; 	goto 188
		176	[1057]	TGETS	 34	31	17	; slot34 = spawn.cant_increment
		177	[1057]	GGET 	 35		35	; slot35 = _env["math"]
		178	[1057]	TGETS	 35	35	16	; slot35 = math.floor
		179	[1057]	GGET 	 36		35	; slot36 = _env["math"]
		180	[1057]	TGETS	 36	36	15	; slot36 = math.min
		181	[1057]	MOV  	 37		21	; slot37 = cycle_index
		182	[1057]	MOV  	 38		4	; slot38 = waves_per_load
		183	[1057]	CALL 	 36	2	3	; slot36 = math.min(cycle_index, waves_per_load)
		184	[1057]	TGETS	 37	31	18	; slot37 = spawn.cant_cicle
		185	[1057]	DIVVV	 36	36	37	; slot36 = math.min / spawn.cant_cicle
		186	[1057]	CALL 	 35	2	2	; slot35 = math.floor(slot36)
		187	[1057]	MULVV	 34	34	35	; slot34 = spawn.cant_increment * math.floor
		188	[1057]	ADDVV	 33	33	34	; slot33 = spawn.cant + slot34
		189	[1057]	TSETS	 33	32	27	; slot32.max = slot33
		190	[1058]	TGETS	 33	31	14	; slot33 = spawn.interval
		191	[1058]	TSETS	 33	32	14	; slot32.interval = spawn.interval
		192	[1059]	TGETS	 33	31	13	; slot33 = spawn.interval_next
		193	[1059]	TSETS	 33	32	13	; slot32.interval_next = spawn.interval_next
		194	[1060]	TGETS	 33	31	12	; slot33 = spawn.use_fixed_path
		195	[1060]	TSETS	 33	32	11	; slot32.fixed_sub_path = spawn.use_fixed_path
		196	[1061]	TGETS	 33	31	10	; slot33 = spawn.path
		197	[1061]	ADDVN	 33	33	0	; slot33 = spawn.path + 1
		198	[1061]	TSETS	 33	32	10	; slot32.path = slot33
		199	[1063]	GGET 	 33		51	; slot33 = _env["table"]
		200	[1063]	TGETS	 33	33	47	; slot33 = table.insert
		201	[1063]	TGETS	 34	25	24	; slot34 = o_wave.spawns
		202	[1063]	MOV  	 35		32	; slot35 = o_spawn
		203	[1063]	CALL 	 33	1	3	;  = table.insert(o_wave.spawns, o_spawn)
		204	[1064]	UGET 	 33		2	; slot33 = uv2"E"
		205	[1064]	MOV  	 34		33	; slot34 = uv2"E"
		206	[1064]	TGETS	 33	33	9	; slot33 = uv2"E".get_template
		207	[1064]	TGETS	 35	31	23	; slot35 = spawn.creep
		208	[1064]	CALL 	 33	2	3	; slot33 = uv2"E".get_template(uv2"E", spawn.creep)
		209	[1065]	ISF  	   		33	; if not tpl
		210	[1065]	JMP  	 34		9	; 	goto 220
		211	[1065]	GGET 	 34		8	; slot34 = _env["bit"]
		212	[1065]	TGETS	 34	34	7	; slot34 = bit.band
		213	[1065]	TGETS	 35	33	6	; slot35 = tpl.vis
		214	[1065]	TGETS	 35	35	5	; slot35 = tpl.vis.flags
		215	[1065]	GGET 	 36		4	; slot36 = _env["F_FLYING"]
		216	[1065]	CALL 	 34	2	3	; slot34 = bit.band(tpl.vis.flags, F_FLYING)
		217	[1065]	ISEQN	 34		1	; if bit.band == 0
		218	[1065]	JMP  	 34		1	; 	goto 220
		219	[1066]	KPRI 	 26		2	; slot26 = true
		220	[1068]	UGET 	 34		1	; slot34 = uv1"log"
		221	[1068]	TGETS	 34	34	32	; slot34 = uv1"log".paranoid
		222	[1068]	KSTR 	 35		3	; slot35 = "   ENDLESS SPAWN index:%03i - max:%03i creep:%s  maxSame:%i interval:%i interval_next:%i path:%i cycle_index:%i"
		223	[1069]	MOV  	 36		1	; slot36 = i
		224	[1069]	TGETS	 37	32	27	; slot37 = o_spawn.max
		225	[1069]	TGETS	 38	32	23	; slot38 = o_spawn.creep
		226	[1069]	TGETS	 39	32	20	; slot39 = o_spawn.max_same
		227	[1069]	TGETS	 40	32	14	; slot40 = o_spawn.interval
		228	[1069]	TGETS	 41	32	13	; slot41 = o_spawn.interval_next
		229	[1069]	TGETS	 42	32	10	; slot42 = o_spawn.path
		230	[1069]	MOV  	 43		21	; slot43 = cycle_index
		231	[1068]	CALL 	 34	1	10	;  = uv1"log".paranoid(slot35, i, o_spawn.max, o_spawn.creep, o_spawn.max_same, o_spawn.interval, o_spawn.interval_next, o_spawn.path, cycle_index)
		232	[1052]	ITERN	 30	3	3	; slot30, slot31, slot32 = slot27<generator>, slot28<state>, slot29<control>; slot30, slot31 = slot27<generator>(slot28<state>, slot29<control>)
		233	[1052]	ITERL	 30		-71	; slot29<control> = slot30; if slot30 != nil goto 163
		234	[1071]	UGET 	 27		0	; slot27 = uv0"km"
		235	[1071]	TGETS	 27	27	34	; slot27 = uv0"km".zmod
		236	[1071]	MOV  	 28		20	; slot28 = pi
		237	[1071]	LEN  	 29		3	; slot29 = #paths_order
		238	[1071]	CALL 	 27	2	3	; slot27 = uv0"km".zmod(pi, slot29)
		239	[1071]	TGETV	 27	3	27	; slot27 = paths_order[uv0"km".zmod]
		240	[1071]	TSETS	 27	25	2	; o_wave.path_index = slot27
		241	[1072]	TSETS	 26	25	1	; o_wave.some_flying = has_some_flying
		242	[1073]	GGET 	 27		51	; slot27 = _env["table"]
		243	[1073]	TGETS	 27	27	47	; slot27 = table.insert
		244	[1073]	TGETS	 28	15	36	; slot28 = o_group.waves
		245	[1073]	MOV  	 29		25	; slot29 = o_wave
		246	[1073]	CALL 	 27	1	3	;  = table.insert(o_group.waves, o_wave)
		247	[1015]	FORL 	 17		-173	; slot20 = slot20 + slot19<step>; if cmp(slot20, sign slot19<step>,  slot18<limit>) goto 75
		248	[1076]	ISNEN	 16		1	; if wave_interval ~= 0
		249	[1076]	JMP  	 17		2	; 	goto 252
		250	[1076]	KSHORT	 17		100	; slot17 = 100
		251	[1076]	JMP  	 18		1	; 	goto 253
		252	[1076]	MOV  	 17		16	; slot17 = wave_interval
		253	[1076]	TSETS	 17	15	14	; o_group.interval = wave_interval
		254	[1079]	KSHORT	 17		0	; slot17 = 0
		255	[1079]	ISGE 	 17		1	; if slot17 >= i
		256	[1079]	JMP  	 17		12	; 	goto 269
		257	[1079]	MODVV	 17	1	4	; slot17 = i % waves_per_load
		258	[1079]	ISNEN	 17		1	; if slot17 ~= 0
		259	[1079]	JMP  	 17		9	; 	goto 269
		260	[1080]	UGET 	 17		0	; slot17 = uv0"km"
		261	[1080]	TGETS	 17	17	44	; slot17 = uv0"km".clamp
		262	[1080]	KSHORT	 18		1	; slot18 = 1
		263	[1080]	MOV  	 19		7	; slot19 = dif_max
		264	[1080]	ADDVN	 20	6	0	; slot20 = dif_idx + 1
		265	[1080]	CALL 	 17	2	4	; slot17 = uv0"km".clamp(slot18, dif_max, slot20)
		266	[1080]	MOV  	  6		17	; slot6 = uv0"km".clamp
		267	[1081]	KSHORT	 14		0	; slot14 = 0
		268	[1082]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		269	[1086]	TGETS	 17	2	56	; slot17 = db.vars
		270	[1086]	TSETS	  6	17	46	; db.vars.dif_idx = dif_idx
		271	[1087]	TGETS	 17	2	56	; slot17 = db.vars
		272	[1087]	TSETS	 14	17	38	; db.vars.next_dif_uses = next_dif_uses
		273	[1088]	TGETS	 17	2	56	; slot17 = db.vars
		274	[1088]	TSETS	  5	17	54	; db.vars.used_waves = used_waves
		275	[1090]	UGET 	 17		1	; slot17 = uv1"log"
		276	[1090]	TGETS	 17	17	32	; slot17 = uv1"log".paranoid
		277	[1090]	KSTR 	 18		0	; slot18 = "group %s:
		 %s"
		278	[1090]	MOV  	 19		1	; slot19 = i
		279	[1090]	GGET 	 20		30	; slot20 = _env["getfulldump"]
		280	[1090]	MOV  	 21		15	; slot21 = o_group
		281	[1090]	CALL 	 20	0	2	; MULTRES = getfulldump(o_group)
		282	[1090]	CALLM	 17	1	2	;  = uv1"log".paranoid(slot18, i, ...MULTRES)
		283	[1092]	UCLO 	  0		0	; nil uvs >= r0; goto 284
		284	[1092]	RET1 	 15		2	; return o_group
	238	[982]	TSETS	 14	5	3	; wave_db.get_endless_group = slot14
	239	[1218]	FNEW 	 14		0	; @./all/wave_db.lua:1095-1218: 3 args, 2 upvalues, 17 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	km
		;;;; variable info ;;;;
		  0-170:	self
		  0-170:	e
		  0-170:	wave_idx
		  1-170:	prog_value
		  2-170:	prog_factor
		  70-94:	damage_factor
		  105-143:	<generator>
		  105-143:	<state>
		  105-143:	<control>
		  106-141:	_
		  106-141:	item
		  107-141:	fmt
		  120-141:	n
		  123-141:	nf
		  124-141:	env
		;;;; instructions ;;;;
		  1	[1169]	FNEW 	  3		33	; @./all/wave_db.lua:1097-1169: 2 args, 5 upvalues, 15 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			  0:	self
			  1:	log
			  2:	e
			  3:	wave_idx
			  4:	km
			;;;; variable info ;;;;
			  0-216:	key
			  0-216:	raw_value
			  1-216:	t
			  4-216:	tall
			  8-216:	tdefault
			  22-40:	parts
			  28-32:	<index>
			  28-32:	<limit>
			  28-32:	<step>
			  29-31:	i
			  88-216:	waves_count
			  118-216:	mult
			  118-216:	val
			  130-145:	cycle
			  134-145:	step_idx
			  150-215:	factor
			  154-215:	base
			  158-215:	cycle
			  176-215:	limit
			;;;; instructions ;;;;
			  1	[1098]	KPRI 	  2		0	; slot2 = nil
			  2	[1099]	UGET 	  3		0	; slot3 = uv0"self"
			  3	[1099]	TGETS	  3	3	30	; slot3 = uv0"self".db
			  4	[1099]	TGETS	  3	3	29	; slot3 = uv0"self".db.enemyProgression
			  5	[1100]	UGET 	  4		0	; slot4 = uv0"self"
			  6	[1100]	TGETS	  4	4	30	; slot4 = uv0"self".db
			  7	[1100]	TGETS	  4	4	29	; slot4 = uv0"self".db.enemyProgression
			  8	[1100]	TGETS	  4	4	28	; slot4 = uv0"self".db.enemyProgression.DEFAULT
			  9	[1101]	GGET 	  5		27	; slot5 = _env["string"]
			 10	[1101]	TGETS	  5	5	26	; slot5 = string.find
			 11	[1101]	MOV  	  6		0	; slot6 = key
			 12	[1101]	KSTR 	  7		25	; slot7 = "."
			 13	[1101]	KSHORT	  8		1	; slot8 = 1
			 14	[1101]	KPRI 	  9		2	; slot9 = true
			 15	[1101]	CALL 	  5	2	5	; slot5 = string.find(key, slot7, slot8, slot9)
			 16	[1101]	ISEQP	  5		0	; if slot5 == nil
			 17	[1101]	JMP  	  5		24	; 	goto 42
			 18	[1102]	GGET 	  5		27	; slot5 = _env["string"]
			 19	[1102]	TGETS	  5	5	24	; slot5 = string.split
			 20	[1102]	MOV  	  6		0	; slot6 = key
			 21	[1102]	KSTR 	  7		25	; slot7 = "."
			 22	[1102]	CALL 	  5	2	3	; slot5 = string.split(key, slot7)
			 23	[1103]	UGET 	  6		0	; slot6 = uv0"self"
			 24	[1103]	TGETS	  6	6	30	; slot6 = uv0"self".db
			 25	[1103]	TGETS	  2	6	29	; slot2 = uv0"self".db.enemyProgression
			 26	[1104]	KSHORT	  6		1	; slot6 = 1
			 27	[1104]	LEN  	  7		5	; slot7 = #parts
			 28	[1104]	KSHORT	  8		1	; slot8 = 1
			 29	[1104]	FORI 	  6		3	; for slot9 = slot6,slot7,slot8 else goto 33
			 30	[1105]	TGETV	 10	5	9	; slot10 = parts[i]
			 31	[1105]	TGETV	  2	2	10	; slot2 = t[slot10]
			 32	[1104]	FORL 	  6		-3	; slot9 = slot9 + slot8<step>; if cmp(slot9, sign slot8<step>,  slot7<limit>) goto 30
			 33	[1107]	IST  	   		2	; if t
			 34	[1107]	JMP  	  6		36	; 	goto 71
			 35	[1108]	UGET 	  6		1	; slot6 = uv1"log"
			 36	[1108]	TGETS	  6	6	23	; slot6 = uv1"log".error
			 37	[1108]	KSTR 	  7		22	; slot7 = "entity progression not found for key %s"
			 38	[1108]	MOV  	  8		0	; slot8 = key
			 39	[1108]	CALL 	  6	1	3	;  = uv1"log".error(slot7, key)
			 40	[1109]	RET1 	  1		2	; return raw_value
			 41	[1110]	JMP  	  5		29	; 	goto 71
			 42	[1112]	UGET 	  5		2	; slot5 = uv2"e"
			 43	[1112]	TGETS	  5	5	21	; slot5 = uv2"e".template_name
			 44	[1112]	TGETV	  5	3	5	; slot5 = tall[uv2"e".template_name]
			 45	[1112]	ISF  	   		5	; if not slot5
			 46	[1112]	JMP  	  6		20	; 	goto 67
			 47	[1112]	UGET 	  5		2	; slot5 = uv2"e"
			 48	[1112]	TGETS	  5	5	21	; slot5 = uv2"e".template_name
			 49	[1112]	TGETV	  5	3	5	; slot5 = tall[uv2"e".template_name]
			 50	[1112]	TGETV	  5	5	0	; slot5 = slot5[key]
			 51	[1112]	ISF  	   		5	; if not slot5
			 52	[1112]	JMP  	  6		14	; 	goto 67
			 53	[1113]	GGET 	  5		20	; slot5 = _env["table"]
			 54	[1113]	TGETS	  5	5	19	; slot5 = table.merge
			 55	[1113]	TGETV	  6	4	0	; slot6 = tdefault[key]
			 56	[1113]	IST  	   		6	; if slot6
			 57	[1113]	JMP  	  7		1	; 	goto 59
			 58	[1113]	TNEW 	  6		0	; slot6 = new table( array: 0, dict: 1)
			 59	[1113]	UGET 	  7		2	; slot7 = uv2"e"
			 60	[1113]	TGETS	  7	7	21	; slot7 = uv2"e".template_name
			 61	[1113]	TGETV	  7	3	7	; slot7 = tall[uv2"e".template_name]
			 62	[1113]	TGETV	  7	7	0	; slot7 = slot7[key]
			 63	[1113]	KPRI 	  8		2	; slot8 = true
			 64	[1113]	CALL 	  5	2	4	; slot5 = table.merge(slot6, slot7, slot8)
			 65	[1113]	MOV  	  2		5	; slot2 = table.merge
			 66	[1113]	JMP  	  5		4	; 	goto 71
			 67	[1115]	TGETV	  5	4	0	; slot5 = tdefault[key]
			 68	[1115]	ISTC 	  2		5	; slot2 = slot5; if slot5
			 69	[1115]	JMP  	  6		1	; 	goto 71
			 70	[1115]	TNEW 	  2		0	; slot2 = new table( array: 0, dict: 1)
			 71	[1119]	UGET 	  5		0	; slot5 = uv0"self"
			 72	[1119]	TGETS	  5	5	30	; slot5 = uv0"self".db
			 73	[1119]	TGETS	  5	5	18	; slot5 = uv0"self".db.vars
			 74	[1119]	TGETS	  5	5	17	; slot5 = uv0"self".db.vars.first_entity_wave
			 75	[1119]	UGET 	  6		2	; slot6 = uv2"e"
			 76	[1119]	TGETS	  6	6	21	; slot6 = uv2"e".template_name
			 77	[1119]	TGETV	  5	5	6	; slot5 = uv0"self".db.vars.first_entity_wave[uv2"e".template_name]
			 78	[1119]	IST  	   		5	; if slot5
			 79	[1119]	JMP  	  5		8	; 	goto 88
			 80	[1120]	UGET 	  5		0	; slot5 = uv0"self"
			 81	[1120]	TGETS	  5	5	30	; slot5 = uv0"self".db
			 82	[1120]	TGETS	  5	5	18	; slot5 = uv0"self".db.vars
			 83	[1120]	TGETS	  5	5	17	; slot5 = uv0"self".db.vars.first_entity_wave
			 84	[1120]	UGET 	  6		2	; slot6 = uv2"e"
			 85	[1120]	TGETS	  6	6	21	; slot6 = uv2"e".template_name
			 86	[1120]	UGET 	  7		3	; slot7 = uv3"wave_idx"
			 87	[1120]	TSETV	  7	5	6	; uv0"self".db.vars.first_entity_wave[uv2"e".template_name] = uv3"wave_idx"
			 88	[1123]	UGET 	  5		3	; slot5 = uv3"wave_idx"
			 89	[1124]	TGETS	  6	2	16	; slot6 = t.activeAfterWave
			 90	[1124]	ISF  	   		6	; if not t.activeAfterWave
			 91	[1124]	JMP  	  7		18	; 	goto 110
			 92	[1125]	UGET 	  6		3	; slot6 = uv3"wave_idx"
			 93	[1125]	TGETS	  7	2	16	; slot7 = t.activeAfterWave
			 94	[1125]	ISGE 	  6		7	; if uv3"wave_idx" >= t.activeAfterWave
			 95	[1125]	JMP  	  6		11	; 	goto 107
			 96	[1126]	UGET 	  6		1	; slot6 = uv1"log"
			 97	[1126]	TGETS	  6	6	15	; slot6 = uv1"log".paranoid
			 98	[1126]	KSTR 	  7		14	; slot7 = "(%s)%s - %s activeAfterWave %s"
			 99	[1126]	UGET 	  8		2	; slot8 = uv2"e"
			100	[1126]	TGETS	  8	8	13	; slot8 = uv2"e".id
			101	[1126]	UGET 	  9		2	; slot9 = uv2"e"
			102	[1126]	TGETS	  9	9	21	; slot9 = uv2"e".template_name
			103	[1126]	MOV  	 10		0	; slot10 = key
			104	[1126]	TGETS	 11	2	16	; slot11 = t.activeAfterWave
			105	[1126]	CALL 	  6	1	6	;  = uv1"log".paranoid(slot7, uv2"e".id, uv2"e".template_name, key, t.activeAfterWave)
			106	[1127]	RET1 	  1		2	; return raw_value
			107	[1129]	TGETS	  6	2	16	; slot6 = t.activeAfterWave
			108	[1129]	SUBVV	  5	5	6	; slot5 = waves_count - t.activeAfterWave
			109	[1129]	JMP  	  6		8	; 	goto 118
			110	[1131]	UGET 	  6		0	; slot6 = uv0"self"
			111	[1131]	TGETS	  6	6	30	; slot6 = uv0"self".db
			112	[1131]	TGETS	  6	6	18	; slot6 = uv0"self".db.vars
			113	[1131]	TGETS	  6	6	17	; slot6 = uv0"self".db.vars.first_entity_wave
			114	[1131]	UGET 	  7		2	; slot7 = uv2"e"
			115	[1131]	TGETS	  7	7	21	; slot7 = uv2"e".template_name
			116	[1131]	TGETV	  6	6	7	; slot6 = uv0"self".db.vars.first_entity_wave[uv2"e".template_name]
			117	[1131]	SUBVV	  5	5	6	; slot5 = waves_count - slot6
			118	[1134]	KNIL 	  6		7	; slot6, uv2"e".template_name = nil
			119	[1135]	TGETS	  8	2	12	; slot8 = t.factor_steps
			120	[1135]	ISF  	   		8	; if not t.factor_steps
			121	[1135]	JMP  	  9		25	; 	goto 147
			122	[1135]	TGETS	  8	2	12	; slot8 = t.factor_steps
			123	[1135]	LEN  	  8		8	; slot8 = #t.factor_steps
			124	[1135]	KSHORT	  9		0	; slot9 = 0
			125	[1135]	ISGE 	  9		8	; if slot9 >= slot8
			126	[1135]	JMP  	  8		20	; 	goto 147
			127	[1137]	TGETS	  8	2	11	; slot8 = t.cicle
			128	[1137]	IST  	   		8	; if t.cicle
			129	[1137]	JMP  	  9		1	; 	goto 131
			130	[1137]	KSHORT	  8		1	; slot8 = 1
			131	[1138]	GGET 	  9		10	; slot9 = _env["math"]
			132	[1138]	TGETS	  9	9	9	; slot9 = math.ceil
			133	[1138]	DIVVV	 10	5	8	; slot10 = waves_count / cycle
			134	[1138]	CALL 	  9	2	2	; slot9 = math.ceil(slot10)
			135	[1139]	UGET 	 10		4	; slot10 = uv4"km"
			136	[1139]	TGETS	 10	10	8	; slot10 = uv4"km".clamp
			137	[1139]	KSHORT	 11		1	; slot11 = 1
			138	[1139]	TGETS	 12	2	12	; slot12 = t.factor_steps
			139	[1139]	LEN  	 12		12	; slot12 = #t.factor_steps
			140	[1139]	MOV  	 13		9	; slot13 = step_idx
			141	[1139]	CALL 	 10	2	4	; slot10 = uv4"km".clamp(slot11, slot12, step_idx)
			142	[1139]	MOV  	  9		10	; slot9 = uv4"km".clamp
			143	[1140]	TGETS	 10	2	12	; slot10 = t.factor_steps
			144	[1140]	TGETV	  6	10	9	; slot6 = t.factor_steps[step_idx]
			145	[1141]	MULVV	  7	6	1	; slot7 = mult * raw_value
			146	[1141]	JMP  	  8		69	; 	goto 216
			147	[1143]	TGETS	  8	2	7	; slot8 = t.factor
			148	[1143]	IST  	   		8	; if t.factor
			149	[1143]	JMP  	  9		1	; 	goto 151
			150	[1143]	KSHORT	  8		1	; slot8 = 1
			151	[1144]	TGETS	  9	2	6	; slot9 = t.base
			152	[1144]	IST  	   		9	; if t.base
			153	[1144]	JMP  	 10		1	; 	goto 155
			154	[1144]	KSHORT	  9		1	; slot9 = 1
			155	[1145]	TGETS	 10	2	11	; slot10 = t.cicle
			156	[1145]	IST  	   		10	; if t.cicle
			157	[1145]	JMP  	 11		1	; 	goto 159
			158	[1145]	KSHORT	 10		1	; slot10 = 1
			159	[1146]	GGET 	 11		10	; slot11 = _env["math"]
			160	[1146]	TGETS	 11	11	5	; slot11 = math.pow
			161	[1146]	MOV  	 12		8	; slot12 = factor
			162	[1146]	GGET 	 13		10	; slot13 = _env["math"]
			163	[1146]	TGETS	 13	13	4	; slot13 = math.floor
			164	[1146]	DIVVV	 14	5	10	; slot14 = waves_count / cycle
			165	[1146]	CALL 	 13	0	2	; MULTRES = math.floor(slot14)
			166	[1146]	CALLM	 11	2	1	; slot11 = math.pow(factor, ...MULTRES)
			167	[1146]	MULVV	  6	9	11	; slot6 = base * math.pow
			168	[1149]	TGETS	 11	2	3	; slot11 = t.limit
			169	[1149]	IST  	   		11	; if t.limit
			170	[1149]	JMP  	 12		6	; 	goto 177
			171	[1149]	KSHORT	 11		1	; slot11 = 1
			172	[1149]	ISGE 	 11		8	; if slot11 >= factor
			173	[1149]	JMP  	 11		2	; 	goto 176
			174	[1149]	KNUM 	 11		0	; slot11 = 99999
			175	[1149]	JMP  	 12		1	; 	goto 177
			176	[1149]	KNUM 	 11		1	; slot11 = -99999
			177	[1150]	KSHORT	 12		1	; slot12 = 1
			178	[1150]	ISGE 	 12		8	; if slot12 >= factor
			179	[1150]	JMP  	 12		7	; 	goto 187
			180	[1151]	GGET 	 12		10	; slot12 = _env["math"]
			181	[1151]	TGETS	 12	12	2	; slot12 = math.min
			182	[1151]	MOV  	 13		6	; slot13 = mult
			183	[1151]	MOV  	 14		11	; slot14 = limit
			184	[1151]	CALL 	 12	2	3	; slot12 = math.min(mult, limit)
			185	[1151]	MOV  	  6		12	; slot6 = math.min
			186	[1151]	JMP  	 12		9	; 	goto 196
			187	[1152]	KSHORT	 12		1	; slot12 = 1
			188	[1152]	ISGE 	  8		12	; if factor >= slot12
			189	[1152]	JMP  	 12		6	; 	goto 196
			190	[1153]	GGET 	 12		10	; slot12 = _env["math"]
			191	[1153]	TGETS	 12	12	1	; slot12 = math.max
			192	[1153]	MOV  	 13		6	; slot13 = mult
			193	[1153]	MOV  	 14		11	; slot14 = limit
			194	[1153]	CALL 	 12	2	3	; slot12 = math.max(mult, limit)
			195	[1153]	MOV  	  6		12	; slot6 = math.max
			196	[1156]	MULVV	  7	6	1	; slot7 = mult * raw_value
			197	[1159]	TGETS	 12	2	0	; slot12 = t.limit_value
			198	[1159]	ISF  	   		12	; if not t.limit_value
			199	[1159]	JMP  	 13		16	; 	goto 216
			200	[1160]	KSHORT	 12		1	; slot12 = 1
			201	[1160]	ISGE 	  8		12	; if factor >= slot12
			202	[1160]	JMP  	 12		7	; 	goto 210
			203	[1161]	GGET 	 12		10	; slot12 = _env["math"]
			204	[1161]	TGETS	 12	12	1	; slot12 = math.max
			205	[1161]	MOV  	 13		7	; slot13 = val
			206	[1161]	TGETS	 14	2	0	; slot14 = t.limit_value
			207	[1161]	CALL 	 12	2	3	; slot12 = math.max(val, t.limit_value)
			208	[1161]	MOV  	  7		12	; slot7 = math.max
			209	[1161]	JMP  	 12		6	; 	goto 216
			210	[1163]	GGET 	 12		10	; slot12 = _env["math"]
			211	[1163]	TGETS	 12	12	2	; slot12 = math.min
			212	[1163]	MOV  	 13		7	; slot13 = val
			213	[1163]	TGETS	 14	2	0	; slot14 = t.limit_value
			214	[1163]	CALL 	 12	2	3	; slot12 = math.min(val, t.limit_value)
			215	[1163]	MOV  	  7		12	; slot7 = math.min
			216	[1168]	RET1 	  7		2	; return val
		  2	[1173]	FNEW 	  4		32	; @./all/wave_db.lua:1171-1173: 1 args, 1 upvalues, 4 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			  0:	prog_value
			;;;; variable info ;;;;
			  0-4:	key
			;;;; instructions ;;;;
			  1	[1172]	UGET 	  1		0	; slot1 = uv0"prog_value"
			  2	[1172]	MOV  	  2		0	; slot2 = key
			  3	[1172]	KSHORT	  3		1	; slot3 = 1
			  4	[1172]	CALLT	  1		3	; return uv0"prog_value"(key, slot3)
		  3	[1176]	TGETS	  5	1	31	; slot5 = e.enemy
		  4	[1176]	ISF  	   		5	; if not e.enemy
		  5	[1176]	JMP  	  6		89	; 	goto 95
		  6	[1177]	TGETS	  5	1	31	; slot5 = e.enemy
		  7	[1177]	UGET 	  6		1	; slot6 = uv1"km"
		  8	[1177]	TGETS	  6	6	29	; slot6 = uv1"km".clamp
		  9	[1177]	KSHORT	  7		0	; slot7 = 0
		 10	[1177]	TGETS	  8	1	31	; slot8 = e.enemy
		 11	[1177]	TGETS	  8	8	30	; slot8 = e.enemy.gold
		 12	[1177]	UGET 	  9		1	; slot9 = uv1"km"
		 13	[1177]	TGETS	  9	9	28	; slot9 = uv1"km".round
		 14	[1177]	MOV  	 10		3	; slot10 = prog_value
		 15	[1177]	KSTR 	 11		30	; slot11 = "gold"
		 16	[1177]	TGETS	 12	1	31	; slot12 = e.enemy
		 17	[1177]	TGETS	 12	12	30	; slot12 = e.enemy.gold
		 18	[1177]	CALL 	 10	0	3	; MULTRES = prog_value(slot11, e.enemy.gold)
		 19	[1177]	CALLM	  9	0	0	; MULTRES = uv1"km".round(, ...MULTRES)
		 20	[1177]	CALLM	  6	2	2	; slot6 = uv1"km".clamp(slot7, e.enemy.gold, ...MULTRES)
		 21	[1177]	TSETS	  6	5	30	; e.enemy.gold = uv1"km".clamp
		 22	[1178]	TGETS	  5	1	27	; slot5 = e.health
		 23	[1178]	ISF  	   		5	; if not e.health
		 24	[1178]	JMP  	  6		35	; 	goto 60
		 25	[1179]	TGETS	  5	1	27	; slot5 = e.health
		 26	[1179]	UGET 	  6		1	; slot6 = uv1"km"
		 27	[1179]	TGETS	  6	6	28	; slot6 = uv1"km".round
		 28	[1179]	MOV  	  7		3	; slot7 = prog_value
		 29	[1179]	KSTR 	  8		27	; slot8 = "health"
		 30	[1179]	TGETS	  9	1	27	; slot9 = e.health
		 31	[1179]	TGETS	  9	9	26	; slot9 = e.health.hp_max
		 32	[1179]	CALL 	  7	0	3	; MULTRES = prog_value(slot8, e.health.hp_max)
		 33	[1179]	CALLM	  6	2	0	; slot6 = uv1"km".round(, ...MULTRES)
		 34	[1179]	TSETS	  6	5	26	; e.health.hp_max = uv1"km".round
		 35	[1180]	TGETS	  5	1	27	; slot5 = e.health
		 36	[1180]	UGET 	  6		1	; slot6 = uv1"km"
		 37	[1180]	TGETS	  6	6	28	; slot6 = uv1"km".round
		 38	[1180]	MOV  	  7		4	; slot7 = prog_factor
		 39	[1180]	KSTR 	  8		25	; slot8 = "megaHealth"
		 40	[1180]	CALL 	  7	2	2	; slot7 = prog_factor(slot8)
		 41	[1180]	TGETS	  8	1	27	; slot8 = e.health
		 42	[1180]	TGETS	  8	8	26	; slot8 = e.health.hp_max
		 43	[1180]	MULVV	  7	7	8	; slot7 = prog_factor * e.health.hp_max
		 44	[1180]	CALL 	  6	2	2	; slot6 = uv1"km".round(slot7)
		 45	[1180]	TSETS	  6	5	26	; e.health.hp_max = uv1"km".round
		 46	[1181]	TGETS	  5	1	27	; slot5 = e.health
		 47	[1181]	MOV  	  6		3	; slot6 = prog_value
		 48	[1181]	KSTR 	  7		24	; slot7 = "armor"
		 49	[1181]	TGETS	  8	1	27	; slot8 = e.health
		 50	[1181]	TGETS	  8	8	24	; slot8 = e.health.armor
		 51	[1181]	CALL 	  6	2	3	; slot6 = prog_value(slot7, e.health.armor)
		 52	[1181]	TSETS	  6	5	24	; e.health.armor = prog_value
		 53	[1182]	TGETS	  5	1	27	; slot5 = e.health
		 54	[1182]	MOV  	  6		3	; slot6 = prog_value
		 55	[1182]	KSTR 	  7		22	; slot7 = "magicArmor"
		 56	[1182]	TGETS	  8	1	27	; slot8 = e.health
		 57	[1182]	TGETS	  8	8	23	; slot8 = e.health.magic_armor
		 58	[1182]	CALL 	  6	2	3	; slot6 = prog_value(slot7, e.health.magic_armor)
		 59	[1182]	TSETS	  6	5	23	; e.health.magic_armor = prog_value
		 60	[1184]	TGETS	  5	1	21	; slot5 = e.melee
		 61	[1184]	ISF  	   		5	; if not e.melee
		 62	[1184]	JMP  	  6		32	; 	goto 95
		 63	[1184]	TGETS	  5	1	21	; slot5 = e.melee
		 64	[1184]	TGETS	  5	5	20	; slot5 = e.melee.attacks
		 65	[1184]	TGETB	  5	5	1	; slot5 = e.melee.attacks[1]
		 66	[1184]	ISF  	   		5	; if not slot5
		 67	[1184]	JMP  	  6		27	; 	goto 95
		 68	[1185]	MOV  	  5		4	; slot5 = prog_factor
		 69	[1185]	KSTR 	  6		19	; slot6 = "damage"
		 70	[1185]	CALL 	  5	2	2	; slot5 = prog_factor(slot6)
		 71	[1186]	TGETS	  6	1	21	; slot6 = e.melee
		 72	[1186]	TGETS	  6	6	20	; slot6 = e.melee.attacks
		 73	[1186]	TGETB	  6	6	1	; slot6 = e.melee.attacks[1]
		 74	[1186]	UGET 	  7		1	; slot7 = uv1"km"
		 75	[1186]	TGETS	  7	7	28	; slot7 = uv1"km".round
		 76	[1186]	TGETS	  8	1	21	; slot8 = e.melee
		 77	[1186]	TGETS	  8	8	20	; slot8 = e.melee.attacks
		 78	[1186]	TGETB	  8	8	1	; slot8 = e.melee.attacks[1]
		 79	[1186]	TGETS	  8	8	18	; slot8 = slot8.damage_max
		 80	[1186]	MULVV	  8	5	8	; slot8 = damage_factor * <unknown table>.damage_max
		 81	[1186]	CALL 	  7	2	2	; slot7 = uv1"km".round(slot8)
		 82	[1186]	TSETS	  7	6	18	; slot6.damage_max = uv1"km".round
		 83	[1187]	TGETS	  6	1	21	; slot6 = e.melee
		 84	[1187]	TGETS	  6	6	20	; slot6 = e.melee.attacks
		 85	[1187]	TGETB	  6	6	1	; slot6 = e.melee.attacks[1]
		 86	[1187]	UGET 	  7		1	; slot7 = uv1"km"
		 87	[1187]	TGETS	  7	7	28	; slot7 = uv1"km".round
		 88	[1187]	TGETS	  8	1	21	; slot8 = e.melee
		 89	[1187]	TGETS	  8	8	20	; slot8 = e.melee.attacks
		 90	[1187]	TGETB	  8	8	1	; slot8 = e.melee.attacks[1]
		 91	[1187]	TGETS	  8	8	17	; slot8 = slot8.damage_min
		 92	[1187]	MULVV	  8	5	8	; slot8 = damage_factor * <unknown table>.damage_min
		 93	[1187]	CALL 	  7	2	2	; slot7 = uv1"km".round(slot8)
		 94	[1187]	TSETS	  7	6	17	; slot6.damage_min = uv1"km".round
		 95	[1192]	TGETS	  5	1	16	; slot5 = e.endless
		 96	[1192]	ISF  	   		5	; if not e.endless
		 97	[1192]	JMP  	  6		46	; 	goto 144
		 98	[1192]	TGETS	  5	1	16	; slot5 = e.endless
		 99	[1192]	TGETS	  5	5	15	; slot5 = e.endless.factor_map
		100	[1192]	ISF  	   		5	; if not e.endless.factor_map
		101	[1192]	JMP  	  6		42	; 	goto 144
		102	[1193]	GGET 	  5		14	; slot5 = _env["pairs"]
		103	[1193]	TGETS	  6	1	16	; slot6 = e.endless
		104	[1193]	TGETS	  6	6	15	; slot6 = e.endless.factor_map
		105	[1193]	CALL 	  5	4	2	; slot5, slot6, slot7 = pairs(e.endless.factor_map)
		106	[1193]	ISNEXT	  8		35	; Verify ITERN at 142; goto 142
		107	[1194]	KPRI 	 10		0	; slot10 = nil
		108	[1195]	TGETB	 11	9	3	; slot11 = item[3]
		109	[1195]	ISF  	   		11	; if not slot11
		110	[1195]	JMP  	 12		2	; 	goto 113
		111	[1196]	KSTR 	 10		13	; slot10 = "e.%s = round(prog_value('%s', e.%s))"
		112	[1196]	JMP  	 11		1	; 	goto 114
		113	[1198]	KSTR 	 10		12	; slot10 = "e.%s = prog_value('%s', e.%s)"
		114	[1200]	GGET 	 11		11	; slot11 = _env["string"]
		115	[1200]	TGETS	 11	11	10	; slot11 = string.format
		116	[1200]	MOV  	 12		10	; slot12 = fmt
		117	[1200]	TGETB	 13	9	2	; slot13 = item[2]
		118	[1200]	TGETB	 14	9	1	; slot14 = item[1]
		119	[1200]	TGETB	 15	9	2	; slot15 = item[2]
		120	[1200]	CALL 	 11	2	5	; slot11 = string.format(fmt, slot13, slot14, slot15)
		121	[1201]	GGET 	 12		9	; slot12 = _env["loadstring"]
		122	[1201]	MOV  	 13		11	; slot13 = n
		123	[1201]	CALL 	 12	2	2	; slot12 = loadstring(n)
		124	[1202]	TNEW 	 13		0	; slot13 = new table( array: 0, dict: 1)
		125	[1203]	TSETS	  1	13	8	; env.e = e
		126	[1204]	TSETS	  2	13	7	; env.wave_idx = wave_idx
		127	[1205]	TSETS	  3	13	6	; env.prog_value = prog_value
		128	[1206]	UGET 	 14		1	; slot14 = uv1"km"
		129	[1206]	TGETS	 14	14	28	; slot14 = uv1"km".round
		130	[1206]	TSETS	 14	13	28	; env.round = uv1"km".round
		131	[1207]	GGET 	 14		5	; slot14 = _env["setfenv"]
		132	[1207]	MOV  	 15		12	; slot15 = nf
		133	[1207]	MOV  	 16		13	; slot16 = env
		134	[1207]	CALL 	 14	1	3	;  = setfenv(nf, env)
		135	[1208]	MOV  	 14		12	; slot14 = nf
		136	[1208]	CALL 	 14	1	1	;  = nf()
		137	[1209]	UGET 	 14		0	; slot14 = uv0"log"
		138	[1209]	TGETS	 14	14	4	; slot14 = uv0"log".paranoid
		139	[1209]	KSTR 	 15		3	; slot15 = "  ENDLESS - factor_map: %s"
		140	[1209]	MOV  	 16		11	; slot16 = n
		141	[1209]	CALL 	 14	1	3	;  = uv0"log".paranoid(slot15, n)
		142	[1193]	ITERN	  8	3	3	; slot8, slot9, slot10 = slot5<generator>, slot6<state>, slot7<control>; slot8, slot9 = slot5<generator>(slot6<state>, slot7<control>)
		143	[1193]	ITERL	  8		-37	; slot7<control> = slot8; if slot8 != nil goto 107
		144	[1213]	UGET 	  5		0	; slot5 = uv0"log"
		145	[1213]	TGETS	  5	5	4	; slot5 = uv0"log".paranoid
		146	[1214]	KSTR 	  6		2	; slot6 = "ENDLESS - w:%s (%s)%s | factors - health:%s damage:%s gold:%s armor:%s magic_armor:%s megaHealth:%s "
		147	[1215]	MOV  	  7		2	; slot7 = wave_idx
		148	[1215]	TGETS	  8	1	1	; slot8 = e.id
		149	[1215]	TGETS	  9	1	0	; slot9 = e.template_name
		150	[1216]	MOV  	 10		4	; slot10 = prog_factor
		151	[1216]	KSTR 	 11		27	; slot11 = "health"
		152	[1216]	CALL 	 10	2	2	; slot10 = prog_factor(slot11)
		153	[1216]	MOV  	 11		4	; slot11 = prog_factor
		154	[1216]	KSTR 	 12		19	; slot12 = "damage"
		155	[1216]	CALL 	 11	2	2	; slot11 = prog_factor(slot12)
		156	[1216]	MOV  	 12		4	; slot12 = prog_factor
		157	[1216]	KSTR 	 13		30	; slot13 = "gold"
		158	[1216]	CALL 	 12	2	2	; slot12 = prog_factor(slot13)
		159	[1216]	MOV  	 13		4	; slot13 = prog_factor
		160	[1216]	KSTR 	 14		24	; slot14 = "armor"
		161	[1216]	CALL 	 13	2	2	; slot13 = prog_factor(slot14)
		162	[1216]	MOV  	 14		4	; slot14 = prog_factor
		163	[1216]	KSTR 	 15		22	; slot15 = "magicArmor"
		164	[1216]	CALL 	 14	2	2	; slot14 = prog_factor(slot15)
		165	[1216]	MOV  	 15		4	; slot15 = prog_factor
		166	[1216]	KSTR 	 16		25	; slot16 = "megaHealth"
		167	[1216]	CALL 	 15	0	2	; MULTRES = prog_factor(slot16)
		168	[1213]	CALLM	  5	1	9	;  = uv0"log".paranoid(slot6, wave_idx, e.id, e.template_name, prog_factor, prog_factor, prog_factor, prog_factor, prog_factor, ...MULTRES)
		169	[1218]	UCLO 	  0		0	; nil uvs >= r0; goto 170
		170	[1218]	RET0 	  0		1	; return
	240	[1095]	TSETS	 14	5	1	; wave_db.set_entity_progression = slot14
	241	[1222]	UCLO 	  0		0	; nil uvs >= r0; goto 242
	242	[1222]	RET1 	  5		2	; return wave_db
	
