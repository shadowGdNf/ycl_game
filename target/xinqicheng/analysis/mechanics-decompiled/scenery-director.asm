;
; Disassemble of /var/folders/jr/tn4pzbcj2gj37f5cg3w5qbzm0000gn/T/rea-extracted-f265f614-2b91-4e81-a212-02037bc4e4ba/assets/gc32/all/director.lua
;
; Source file: @./all/director.lua
;
; Flags:
;	Stripped: No
;	Endianness: Little
;	FFI: Not present
;

main @./all/director.lua:0-1242: 0+ args, 0 upvalues, 24 slots
	;;;; constant tables ;;;;
	;;;; upvalue names ;;;;
	;;;; variable info ;;;;
	  7-196:	log
	  10-196:	km
	  13-196:	signal
	  19-196:	features
	  22-196:	i18n
	  25-196:	V
	  28-196:	I
	  31-196:	F
	  34-196:	SH
	  37-196:	KDB
	  40-196:	S
	  42-196:	G
	  45-196:	AC
	  48-196:	LU
	  51-196:	RC
	  54-196:	ISM
	  57-196:	marketing
	  60-196:	PP
	  63-196:	storage
	  66-196:	services
	  69-196:	director_data
	  70-196:	replace_locale
	;;;; instructions ;;;;
	  1	[  5]	GGET 	  0		102	; slot0 = _env["require"]
	  2	[  5]	KSTR 	  1		101	; slot1 = "klua.log"
	  3	[  5]	CALL 	  0	2	2	; slot0 = require(slot1)
	  4	[  5]	MOV  	  1		0	; slot1 = slot0
	  5	[  5]	TGETS	  0	0	100	; slot0 = slot0.new
	  6	[  5]	KSTR 	  2		99	; slot2 = "director"
	  7	[  5]	CALL 	  0	2	3	; slot0 = <unknown table>.new(slot1, slot2)
	  8	[  6]	GGET 	  1		102	; slot1 = _env["require"]
	  9	[  6]	KSTR 	  2		98	; slot2 = "klua.macros"
	 10	[  6]	CALL 	  1	2	2	; slot1 = require(slot2)
	 11	[  7]	GGET 	  2		102	; slot2 = _env["require"]
	 12	[  7]	KSTR 	  3		97	; slot3 = "hump.signal"
	 13	[  7]	CALL 	  2	2	2	; slot2 = require(slot3)
	 14	[  8]	GGET 	  3		102	; slot3 = _env["require"]
	 15	[  8]	KSTR 	  4		96	; slot4 = "klua.dump"
	 16	[  8]	CALL 	  3	1	2	;  = require(slot4)
	 17	[ 10]	GGET 	  3		102	; slot3 = _env["require"]
	 18	[ 10]	KSTR 	  4		95	; slot4 = "features"
	 19	[ 10]	CALL 	  3	2	2	; slot3 = require(slot4)
	 20	[ 12]	GGET 	  4		102	; slot4 = _env["require"]
	 21	[ 12]	KSTR 	  5		94	; slot5 = "i18n"
	 22	[ 12]	CALL 	  4	2	2	; slot4 = require(slot5)
	 23	[ 13]	GGET 	  5		102	; slot5 = _env["require"]
	 24	[ 13]	KSTR 	  6		93	; slot6 = "klua.vector"
	 25	[ 13]	CALL 	  5	2	2	; slot5 = require(slot6)
	 26	[ 14]	GGET 	  6		102	; slot6 = _env["require"]
	 27	[ 14]	KSTR 	  7		92	; slot7 = "klove.image_db"
	 28	[ 14]	CALL 	  6	2	2	; slot6 = require(slot7)
	 29	[ 15]	GGET 	  7		102	; slot7 = _env["require"]
	 30	[ 15]	KSTR 	  8		91	; slot8 = "klove.font_db"
	 31	[ 15]	CALL 	  7	2	2	; slot7 = require(slot8)
	 32	[ 16]	GGET 	  8		102	; slot8 = _env["require"]
	 33	[ 16]	KSTR 	  9		90	; slot9 = "klove.shader_db"
	 34	[ 16]	CALL 	  8	2	2	; slot8 = require(slot9)
	 35	[ 17]	GGET 	  9		102	; slot9 = _env["require"]
	 36	[ 17]	KSTR 	 10		89	; slot10 = "klove.kui_db"
	 37	[ 17]	CALL 	  9	2	2	; slot9 = require(slot10)
	 38	[ 18]	GGET 	 10		102	; slot10 = _env["require"]
	 39	[ 18]	KSTR 	 11		88	; slot11 = "sound_db"
	 40	[ 18]	CALL 	 10	2	2	; slot10 = require(slot11)
	 41	[ 19]	GGET 	 11		87	; slot11 = _env["love"]
	 42	[ 19]	TGETS	 11	11	86	; slot11 = love.graphics
	 43	[ 20]	GGET 	 12		102	; slot12 = _env["require"]
	 44	[ 20]	KSTR 	 13		85	; slot13 = "achievements"
	 45	[ 20]	CALL 	 12	2	2	; slot12 = require(slot13)
	 46	[ 21]	GGET 	 13		102	; slot13 = _env["require"]
	 47	[ 21]	KSTR 	 14		84	; slot14 = "level_utils"
	 48	[ 21]	CALL 	 13	2	2	; slot13 = require(slot14)
	 49	[ 22]	GGET 	 14		102	; slot14 = _env["require"]
	 50	[ 22]	KSTR 	 15		83	; slot15 = "remote_config"
	 51	[ 22]	CALL 	 14	2	2	; slot14 = require(slot15)
	 52	[ 23]	GGET 	 15		102	; slot15 = _env["require"]
	 53	[ 23]	KSTR 	 16		82	; slot16 = "klove.input_state_machine"
	 54	[ 23]	CALL 	 15	2	2	; slot15 = require(slot16)
	 55	[ 24]	GGET 	 16		102	; slot16 = _env["require"]
	 56	[ 24]	KSTR 	 17		81	; slot17 = "marketing"
	 57	[ 24]	CALL 	 16	2	2	; slot16 = require(slot17)
	 58	[ 25]	GGET 	 17		102	; slot17 = _env["require"]
	 59	[ 25]	KSTR 	 18		80	; slot18 = "privacy_policy_consent"
	 60	[ 25]	CALL 	 17	2	2	; slot17 = require(slot18)
	 61	[ 27]	GGET 	 18		102	; slot18 = _env["require"]
	 62	[ 27]	KSTR 	 19		79	; slot19 = "storage"
	 63	[ 27]	CALL 	 18	2	2	; slot18 = require(slot19)
	 64	[ 28]	GGET 	 19		102	; slot19 = _env["require"]
	 65	[ 28]	KSTR 	 20		78	; slot20 = "platform_services"
	 66	[ 28]	CALL 	 19	2	2	; slot19 = require(slot20)
	 67	[ 30]	GGET 	 20		102	; slot20 = _env["require"]
	 68	[ 30]	KSTR 	 21		77	; slot21 = "data.director_data"
	 69	[ 30]	CALL 	 20	2	2	; slot20 = require(slot21)
	 70	[ 41]	FNEW 	 21		76	; @./all/director.lua:34-41: 2 args, 1 upvalues, 12 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	i18n
		;;;; variable info ;;;;
		  0-22:	list
		  0-22:	locale
		  1-22:	out
		  4-21:	<generator>
		  4-21:	<state>
		  4-21:	<control>
		  5-19:	_
		  5-19:	v
		  14-19:	ns
		;;;; instructions ;;;;
		  1	[ 35]	TNEW 	  2		0	; slot2 = new table( array: 0, dict: 1)
		  2	[ 36]	GGET 	  3		6	; slot3 = _env["pairs"]
		  3	[ 36]	MOV  	  4		0	; slot4 = list
		  4	[ 36]	CALL 	  3	4	2	; slot3, slot4, slot5 = pairs(list)
		  5	[ 36]	ISNEXT	  6		14	; Verify ITERN at 20; goto 20
		  6	[ 37]	GGET 	  8		5	; slot8 = _env["string"]
		  7	[ 37]	TGETS	  8	8	4	; slot8 = string.gsub
		  8	[ 37]	MOV  	  9		7	; slot9 = v
		  9	[ 37]	KSTR 	 10		3	; slot10 = "LOCALE"
		 10	[ 37]	ISTC 	 11		1	; slot11 = locale; if locale
		 11	[ 37]	JMP  	 11		2	; 	goto 14
		 12	[ 37]	UGET 	 11		0	; slot11 = uv0"i18n"
		 13	[ 37]	TGETS	 11	11	2	; slot11 = uv0"i18n".current_locale
		 14	[ 37]	CALL 	  8	2	4	; slot8 = string.gsub(v, slot10, uv0"i18n".current_locale)
		 15	[ 38]	GGET 	  9		1	; slot9 = _env["table"]
		 16	[ 38]	TGETS	  9	9	0	; slot9 = table.insert
		 17	[ 38]	MOV  	 10		2	; slot10 = out
		 18	[ 38]	MOV  	 11		8	; slot11 = ns
		 19	[ 38]	CALL 	  9	1	3	;  = table.insert(out, ns)
		 20	[ 36]	ITERN	  6	3	3	; slot6, slot7, slot8 = slot3<generator>, slot4<state>, slot5<control>; slot6, slot7 = slot3<generator>(slot4<state>, slot5<control>)
		 21	[ 36]	ITERL	  6		-16	; slot5<control> = slot6; if slot6 != nil goto 6
		 22	[ 40]	RET1 	  2		2	; return out
	 71	[ 46]	TNEW 	 22		0	; slot22 = new table( array: 0, dict: 1)
	 72	[ 46]	GSET 	 22		99	; _env["director"] = slot22
	 73	[ 47]	GGET 	 22		99	; slot22 = _env["director"]
	 74	[ 47]	TGETS	 23	20	75	; slot23 = director_data.item_props
	 75	[ 47]	TSETS	 23	22	75	; director.item_props = director_data.item_props
	 76	[ 50]	GGET 	 22		99	; slot22 = _env["director"]
	 77	[224]	FNEW 	 23		73	; @./all/director.lua:50-224: 2 args, 12 upvalues, 16 slots
		
		;;;; constant tables ;;;;
		ktable#24 = [
			]
		
		
		ktable#37 = [
			]
		
		
		ktable#42 = [
			]
		
		
		ktable#104 = [
			]
		
		
		;;;; upvalue names ;;;;
		  0:	storage
		  1:	log
		  2:	KDB
		  3:	SH
		  4:	S
		  5:	features
		  6:	I
		  7:	RC
		  8:	AC
		  9:	services
		  10:	PP
		  11:	marketing
		;;;; variable info ;;;;
		  0-490:	self
		  0-490:	params
		  6-490:	global
		  26-490:	kdb_path
		  70-490:	sound_paths
		  73-96:	<generator>
		  73-96:	<state>
		  73-96:	<control>
		  74-94:	_
		  74-94:	v
		  77-94:	p
		  190-195:	filename
		  207-257:	dir
		  272-389:	slot_idx
		  341-389:	ch_id
		  351-389:	found
		  356-378:	<generator>
		  356-378:	<state>
		  356-378:	<control>
		  357-376:	_
		  357-376:	c
		  364-376:	ch
		  407-412:	c
		  414-489:	cursor_name
		;;;; instructions ;;;;
		  1	[ 52]	TNEW 	  2		0	; slot2 = new table( array: 0, dict: 1)
		  2	[ 52]	TSETS	  2	0	122	; self.postponed_unloads = slot2
		  3	[ 54]	UGET 	  2		0	; slot2 = uv0"storage"
		  4	[ 54]	MOV  	  3		2	; slot3 = uv0"storage"
		  5	[ 54]	TGETS	  2	2	121	; slot2 = uv0"storage".load_global
		  6	[ 54]	CALL 	  2	2	2	; slot2 = uv0"storage".load_global(uv0"storage")
		  7	[ 55]	TGETS	  3	2	120	; slot3 = global.launch_count
		  8	[ 55]	IST  	   		3	; if global.launch_count
		  9	[ 55]	JMP  	  3		3	; 	goto 13
		 10	[ 56]	KSHORT	  3		1	; slot3 = 1
		 11	[ 56]	TSETS	  3	2	120	; global.launch_count = slot3
		 12	[ 56]	JMP  	  3		3	; 	goto 16
		 13	[ 58]	TGETS	  3	2	120	; slot3 = global.launch_count
		 14	[ 58]	ADDVN	  3	3	0	; slot3 = global.launch_count + 1
		 15	[ 58]	TSETS	  3	2	120	; global.launch_count = slot3
		 16	[ 60]	UGET 	  3		1	; slot3 = uv1"log"
		 17	[ 60]	TGETS	  3	3	119	; slot3 = uv1"log".debug
		 18	[ 60]	KSTR 	  4		118	; slot4 = "Launch count: %s"
		 19	[ 60]	TGETS	  5	2	120	; slot5 = global.launch_count
		 20	[ 60]	CALL 	  3	1	3	;  = uv1"log".debug(slot4, global.launch_count)
		 21	[ 61]	UGET 	  3		0	; slot3 = uv0"storage"
		 22	[ 61]	MOV  	  4		3	; slot4 = uv0"storage"
		 23	[ 61]	TGETS	  3	3	117	; slot3 = uv0"storage".save_global
		 24	[ 61]	MOV  	  5		2	; slot5 = global
		 25	[ 61]	CALL 	  3	1	3	;  = uv0"storage".save_global(uv0"storage", global)
		 26	[ 63]	KPRI 	  3		0	; slot3 = nil
		 27	[ 64]	GGET 	  4		116	; slot4 = _env["IS_TRILOGY"]
		 28	[ 64]	ISF  	   		4	; if not IS_TRILOGY
		 29	[ 64]	JMP  	  5		7	; 	goto 37
		 30	[ 65]	GGET 	  4		115	; slot4 = _env["KR_PATH_GAME_TARGET"]
		 31	[ 65]	KSTR 	  5		114	; slot5 = "/data/kui_templates"
		 32	[ 66]	KSTR 	  6		113	; slot6 = ";"
		 33	[ 66]	GGET 	  7		112	; slot7 = _env["KR_PATH_ALL_TARGET"]
		 34	[ 66]	KSTR 	  8		114	; slot8 = "/data/kui_templates"
		 35	[ 66]	CAT  	  3	4	8	; slot3 = KR_PATH_GAME_TARGET .. slot5 .. slot6 .. KR_PATH_ALL_TARGET .. slot8
		 36	[ 66]	JMP  	  4		12	; 	goto 49
		 37	[ 68]	GGET 	  4		115	; slot4 = _env["KR_PATH_GAME_TARGET"]
		 38	[ 68]	KSTR 	  5		114	; slot5 = "/data/kui_templates"
		 39	[ 69]	KSTR 	  6		113	; slot6 = ";"
		 40	[ 69]	GGET 	  7		111	; slot7 = _env["KR_PATH_GAME"]
		 41	[ 69]	KSTR 	  8		114	; slot8 = "/data/kui_templates"
		 42	[ 70]	KSTR 	  9		113	; slot9 = ";"
		 43	[ 70]	GGET 	 10		112	; slot10 = _env["KR_PATH_ALL_TARGET"]
		 44	[ 70]	KSTR 	 11		114	; slot11 = "/data/kui_templates"
		 45	[ 71]	KSTR 	 12		113	; slot12 = ";"
		 46	[ 71]	GGET 	 13		110	; slot13 = _env["KR_PATH_ALL"]
		 47	[ 71]	KSTR 	 14		114	; slot14 = "/data/kui_templates"
		 48	[ 71]	CAT  	  3	4	14	; slot3 = KR_PATH_GAME_TARGET .. slot5 .. slot6 .. KR_PATH_GAME .. slot8 .. slot9 .. KR_PATH_ALL_TARGET .. slot11 .. slot12 .. KR_PATH_ALL .. slot14
		 49	[ 73]	UGET 	  4		2	; slot4 = uv2"KDB"
		 50	[ 73]	MOV  	  5		4	; slot5 = uv2"KDB"
		 51	[ 73]	TGETS	  4	4	109	; slot4 = uv2"KDB".init
		 52	[ 73]	MOV  	  6		3	; slot6 = kdb_path
		 53	[ 73]	GGET 	  7		108	; slot7 = _env["DEBUG"]
		 54	[ 73]	CALL 	  4	1	4	;  = uv2"KDB".init(uv2"KDB", kdb_path, DEBUG)
		 55	[ 74]	UGET 	  4		3	; slot4 = uv3"SH"
		 56	[ 74]	MOV  	  5		4	; slot5 = uv3"SH"
		 57	[ 74]	TGETS	  4	4	109	; slot4 = uv3"SH".init
		 58	[ 74]	GGET 	  6		107	; slot6 = _env["KR_PATH_ASSETS_ALL_TARGET"]
		 59	[ 74]	KSTR 	  7		106	; slot7 = "/shaders"
		 60	[ 74]	CAT  	  6	6	7	; slot6 = KR_PATH_ASSETS_ALL_TARGET .. slot7
		 61	[ 74]	KPRI 	  7		2	; slot7 = true
		 62	[ 74]	CALL 	  4	1	4	;  = uv3"SH".init(uv3"SH", slot6, slot7)
		 63	[ 77]	GGET 	  4		105	; slot4 = _env["KR_PATH_ASSETS_GAME_FALLBACK"]
		 64	[ 77]	IST  	   		4	; if KR_PATH_ASSETS_GAME_FALLBACK
		 65	[ 77]	JMP  	  5		5	; 	goto 71
		 66	[ 77]	TNEW 	  4		3	; slot4 = new table( array: 3, dict: 1)
		 67	[ 77]	TDUP 	  5		104	; slot5 = copy table#k104
		 68	[ 77]	GGET 	  6		103	; slot6 = _env["KR_PATH_ASSETS_GAME_TARGET"]
		 69	[ 77]	TSETS	  6	5	102	; slot5.path = KR_PATH_ASSETS_GAME_TARGET
		 70	[ 77]	TSETB	  5	4	1	; slot4[1] = slot5
		 71	[ 78]	GGET 	  5		101	; slot5 = _env["pairs"]
		 72	[ 78]	MOV  	  6		4	; slot6 = sound_paths
		 73	[ 78]	CALL 	  5	4	2	; slot5, slot6, slot7 = pairs(sound_paths)
		 74	[ 78]	ISNEXT	  8		20	; Verify ITERN at 95; goto 95
		 75	[ 79]	TGETS	 10	9	102	; slot10 = v.path
		 76	[ 79]	KSTR 	 11		100	; slot11 = "/sounds"
		 77	[ 79]	CAT  	 10	10	11	; slot10 = v.path .. slot11
		 78	[ 80]	GGET 	 11		99	; slot11 = _env["love"]
		 79	[ 80]	TGETS	 11	11	98	; slot11 = love.filesystem
		 80	[ 80]	TGETS	 11	11	97	; slot11 = love.filesystem.exists
		 81	[ 80]	MOV  	 12		10	; slot12 = p
		 82	[ 80]	KSTR 	 13		96	; slot13 = "/sounds.lua"
		 83	[ 80]	CAT  	 12	12	13	; slot12 = p .. slot13
		 84	[ 80]	CALL 	 11	2	2	; slot11 = love.filesystem.exists(slot12)
		 85	[ 80]	ISF  	   		11	; if not love.filesystem.exists
		 86	[ 80]	JMP  	 12		8	; 	goto 95
		 87	[ 81]	UGET 	 11		4	; slot11 = uv4"S"
		 88	[ 81]	MOV  	 12		11	; slot12 = uv4"S"
		 89	[ 81]	TGETS	 11	11	109	; slot11 = uv4"S".init
		 90	[ 81]	MOV  	 13		10	; slot13 = p
		 91	[ 81]	UGET 	 14		5	; slot14 = uv5"features"
		 92	[ 81]	TGETS	 14	14	95	; slot14 = uv5"features".overrides
		 93	[ 81]	CALL 	 11	1	4	;  = uv4"S".init(uv4"S", p, uv5"features".overrides)
		 94	[ 82]	JMP  	  5		2	; 	goto 97
		 95	[ 78]	ITERN	  8	3	3	; slot8, slot9, slot10 = slot5<generator>, slot6<state>, slot7<control>; slot8, slot9 = slot5<generator>(slot6<state>, slot7<control>)
		 96	[ 78]	ITERL	  8		-22	; slot7<control> = slot8; if slot8 != nil goto 75
		 97	[ 87]	UGET 	  5		6	; slot5 = uv6"I"
		 98	[ 87]	TGETS	  6	1	93	; slot6 = params.image_db_uses_canvas
		 99	[ 87]	TSETS	  6	5	94	; uv6"I".use_canvas = params.image_db_uses_canvas
		100	[ 88]	UGET 	  5		6	; slot5 = uv6"I"
		101	[ 88]	TGETS	  6	1	91	; slot6 = params.image_db_releases_compressed_data
		102	[ 88]	TSETS	  6	5	92	; uv6"I".release_compressed_data = params.image_db_releases_compressed_data
		103	[ 89]	UGET 	  5		6	; slot5 = uv6"I"
		104	[ 89]	MOV  	  6		5	; slot6 = uv6"I"
		105	[ 89]	TGETS	  5	5	90	; slot5 = uv6"I".load_default_atlas
		106	[ 89]	CALL 	  5	1	2	;  = uv6"I".load_default_atlas(uv6"I")
		107	[ 90]	UGET 	  5		7	; slot5 = uv7"RC"
		108	[ 90]	MOV  	  6		5	; slot6 = uv7"RC"
		109	[ 90]	TGETS	  5	5	109	; slot5 = uv7"RC".init
		110	[ 90]	CALL 	  5	1	2	;  = uv7"RC".init(uv7"RC")
		111	[ 91]	UGET 	  5		8	; slot5 = uv8"AC"
		112	[ 91]	MOV  	  6		5	; slot6 = uv8"AC"
		113	[ 91]	TGETS	  5	5	109	; slot5 = uv8"AC".init
		114	[ 91]	CALL 	  5	1	2	;  = uv8"AC".init(uv8"AC")
		115	[ 94]	GGET 	  5		89	; slot5 = _env["KR_TARGET"]
		116	[ 94]	ISEQS	  5		88	; if KR_TARGET == "phone"
		117	[ 94]	JMP  	  5		3	; 	goto 121
		118	[ 94]	GGET 	  5		89	; slot5 = _env["KR_TARGET"]
		119	[ 94]	ISNES	  5		87	; if KR_TARGET ~= "tablet"
		120	[ 94]	JMP  	  5		8	; 	goto 129
		121	[ 94]	GGET 	  5		86	; slot5 = _env["KR_PLATFORM"]
		122	[ 94]	ISNES	  5		85	; if KR_PLATFORM ~= "ios"
		123	[ 94]	JMP  	  5		5	; 	goto 129
		124	[ 95]	UGET 	  5		0	; slot5 = uv0"storage"
		125	[ 95]	MOV  	  6		5	; slot6 = uv0"storage"
		126	[ 95]	TGETS	  5	5	84	; slot5 = uv0"storage".import_plist
		127	[ 95]	KSTR 	  7		83	; slot7 = "NSUserDefaults"
		128	[ 95]	CALL 	  5	1	3	;  = uv0"storage".import_plist(uv0"storage", slot7)
		129	[ 99]	UGET 	  5		9	; slot5 = uv9"services"
		130	[ 99]	MOV  	  6		5	; slot6 = uv9"services"
		131	[ 99]	TGETS	  5	5	109	; slot5 = uv9"services".init
		132	[ 99]	KPRI 	  7		2	; slot7 = true
		133	[ 99]	CALL 	  5	1	3	;  = uv9"services".init(uv9"services", slot7)
		134	[100]	UGET 	  5		10	; slot5 = uv10"PP"
		135	[100]	MOV  	  6		5	; slot6 = uv10"PP"
		136	[100]	TGETS	  5	5	109	; slot5 = uv10"PP".init
		137	[100]	CALL 	  5	1	2	;  = uv10"PP".init(uv10"PP")
		138	[102]	UGET 	  5		10	; slot5 = uv10"PP"
		139	[102]	MOV  	  6		5	; slot6 = uv10"PP"
		140	[102]	TGETS	  5	5	82	; slot5 = uv10"PP".has_consent
		141	[102]	CALL 	  5	2	2	; slot5 = uv10"PP".has_consent(uv10"PP")
		142	[102]	ISF  	   		5	; if not uv10"PP".has_consent
		143	[102]	JMP  	  6		12	; 	goto 156
		144	[102]	UGET 	  5		5	; slot5 = uv5"features"
		145	[102]	TGETS	  5	5	81	; slot5 = uv5"features".delay_services_init
		146	[102]	IST  	   		5	; if uv5"features".delay_services_init
		147	[102]	JMP  	  5		8	; 	goto 156
		148	[103]	UGET 	  5		9	; slot5 = uv9"services"
		149	[103]	MOV  	  6		5	; slot6 = uv9"services"
		150	[103]	TGETS	  5	5	109	; slot5 = uv9"services".init
		151	[103]	CALL 	  5	1	2	;  = uv9"services".init(uv9"services")
		152	[104]	UGET 	  5		11	; slot5 = uv11"marketing"
		153	[104]	MOV  	  6		5	; slot6 = uv11"marketing"
		154	[104]	TGETS	  5	5	109	; slot5 = uv11"marketing".init
		155	[104]	CALL 	  5	1	2	;  = uv11"marketing".init(uv11"marketing")
		156	[107]	TSETS	  1	0	80	; self.params = params
		157	[109]	MOV  	  6		0	; slot6 = self
		158	[109]	TGETS	  5	0	79	; slot5 = self.reset_screen_params
		159	[109]	CALL 	  5	1	2	;  = self.reset_screen_params(self)
		160	[112]	TGETS	  5	1	78	; slot5 = params.locale
		161	[112]	ISF  	   		5	; if not params.locale
		162	[112]	JMP  	  6		17	; 	goto 180
		163	[113]	GGET 	  5		77	; slot5 = _env["main"]
		164	[113]	MOV  	  6		5	; slot6 = main
		165	[113]	TGETS	  5	5	76	; slot5 = main.set_locale
		166	[113]	TGETS	  7	1	78	; slot7 = params.locale
		167	[113]	CALL 	  5	1	3	;  = main.set_locale(main, params.locale)
		168	[115]	GGET 	  5		99	; slot5 = _env["love"]
		169	[115]	TGETS	  5	5	75	; slot5 = love.window
		170	[115]	TGETS	  5	5	74	; slot5 = love.window.setTitle
		171	[115]	GGET 	  6		73	; slot6 = _env["_"]
		172	[115]	KSTR 	  7		72	; slot7 = "GAME_TITLE_"
		173	[115]	GGET 	  8		71	; slot8 = _env["string"]
		174	[115]	TGETS	  8	8	70	; slot8 = string.upper
		175	[115]	GGET 	  9		69	; slot9 = _env["KR_GAME"]
		176	[115]	CALL 	  8	2	2	; slot8 = string.upper(KR_GAME)
		177	[115]	CAT  	  7	7	8	; slot7 = slot7 .. string.upper
		178	[115]	CALL 	  6	0	2	; MULTRES = _(slot7)
		179	[115]	CALLM	  5	1	0	;  = love.window.setTitle(, ...MULTRES)
		180	[119]	GGET 	  5		89	; slot5 = _env["KR_TARGET"]
		181	[119]	ISNES	  5		88	; if KR_TARGET ~= "phone"
		182	[119]	JMP  	  5		14	; 	goto 197
		183	[119]	GGET 	  5		86	; slot5 = _env["KR_PLATFORM"]
		184	[119]	ISNES	  5		68	; if KR_PLATFORM ~= "android"
		185	[119]	JMP  	  5		11	; 	goto 197
		186	[132]	KSTR 	  5		67	; slot5 = "/data/data/"
		187	[132]	GGET 	  6		66	; slot6 = _env["version"]
		188	[132]	TGETS	  6	6	65	; slot6 = version.bundle_id
		189	[132]	KSTR 	  7		64	; slot7 = "/files/.Defaults.plist"
		190	[132]	CAT  	  5	5	7	; slot5 = slot5 .. version.bundle_id .. slot7
		191	[133]	UGET 	  6		0	; slot6 = uv0"storage"
		192	[133]	MOV  	  7		6	; slot7 = uv0"storage"
		193	[133]	TGETS	  6	6	84	; slot6 = uv0"storage".import_plist
		194	[133]	MOV  	  8		5	; slot8 = filename
		195	[133]	CALL 	  6	1	3	;  = uv0"storage".import_plist(uv0"storage", filename)
		196	[133]	JMP  	  5		61	; 	goto 258
		197	[135]	GGET 	  5		89	; slot5 = _env["KR_TARGET"]
		198	[135]	ISNES	  5		63	; if KR_TARGET ~= "desktop"
		199	[135]	JMP  	  5		58	; 	goto 258
		200	[135]	GGET 	  5		69	; slot5 = _env["KR_GAME"]
		201	[135]	ISNES	  5		62	; if KR_GAME ~= "kr1"
		202	[135]	JMP  	  5		55	; 	goto 258
		203	[135]	UGET 	  5		9	; slot5 = uv9"services"
		204	[135]	TGETS	  5	5	61	; slot5 = uv9"services".services
		205	[135]	ISF  	   		5	; if not uv9"services".services
		206	[135]	JMP  	  6		51	; 	goto 258
		207	[136]	KPRI 	  5		0	; slot5 = nil
		208	[137]	UGET 	  6		9	; slot6 = uv9"services"
		209	[137]	TGETS	  6	6	61	; slot6 = uv9"services".services
		210	[137]	TGETS	  6	6	60	; slot6 = uv9"services".services.steam
		211	[137]	ISF  	   		6	; if not uv9"services".services.steam
		212	[137]	JMP  	  7		8	; 	goto 221
		213	[138]	UGET 	  6		9	; slot6 = uv9"services"
		214	[138]	TGETS	  6	6	61	; slot6 = uv9"services".services
		215	[138]	TGETS	  6	6	60	; slot6 = uv9"services".services.steam
		216	[138]	MOV  	  7		6	; slot7 = uv9"services".services.steam
		217	[138]	TGETS	  6	6	59	; slot6 = uv9"services".services.steam.get_install_dir
		218	[138]	CALL 	  6	2	2	; slot6 = uv9"services".services.steam.get_install_dir(uv9"services".services.steam)
		219	[138]	MOV  	  5		6	; slot5 = uv9"services".services.steam.get_install_dir
		220	[138]	JMP  	  6		25	; 	goto 246
		221	[139]	UGET 	  6		9	; slot6 = uv9"services"
		222	[139]	TGETS	  6	6	61	; slot6 = uv9"services".services
		223	[139]	TGETS	  6	6	58	; slot6 = uv9"services".services.gamecenter
		224	[139]	ISF  	   		6	; if not uv9"services".services.gamecenter
		225	[139]	JMP  	  7		8	; 	goto 234
		226	[140]	UGET 	  6		9	; slot6 = uv9"services"
		227	[140]	TGETS	  6	6	61	; slot6 = uv9"services".services
		228	[140]	TGETS	  6	6	58	; slot6 = uv9"services".services.gamecenter
		229	[140]	MOV  	  7		6	; slot7 = uv9"services".services.gamecenter
		230	[140]	TGETS	  6	6	59	; slot6 = uv9"services".services.gamecenter.get_install_dir
		231	[140]	CALL 	  6	2	2	; slot6 = uv9"services".services.gamecenter.get_install_dir(uv9"services".services.gamecenter)
		232	[140]	MOV  	  5		6	; slot5 = uv9"services".services.gamecenter.get_install_dir
		233	[140]	JMP  	  6		12	; 	goto 246
		234	[141]	UGET 	  6		9	; slot6 = uv9"services"
		235	[141]	TGETS	  6	6	61	; slot6 = uv9"services".services
		236	[141]	TGETS	  6	6	57	; slot6 = uv9"services".services.kart
		237	[141]	ISF  	   		6	; if not uv9"services".services.kart
		238	[141]	JMP  	  7		7	; 	goto 246
		239	[142]	UGET 	  6		9	; slot6 = uv9"services"
		240	[142]	TGETS	  6	6	61	; slot6 = uv9"services".services
		241	[142]	TGETS	  6	6	57	; slot6 = uv9"services".services.kart
		242	[142]	MOV  	  7		6	; slot7 = uv9"services".services.kart
		243	[142]	TGETS	  6	6	59	; slot6 = uv9"services".services.kart.get_install_dir
		244	[142]	CALL 	  6	2	2	; slot6 = uv9"services".services.kart.get_install_dir(uv9"services".services.kart)
		245	[142]	MOV  	  5		6	; slot5 = uv9"services".services.kart.get_install_dir
		246	[144]	IST  	   		5	; if dir
		247	[144]	JMP  	  6		5	; 	goto 253
		248	[145]	UGET 	  6		1	; slot6 = uv1"log"
		249	[145]	TGETS	  6	6	56	; slot6 = uv1"log".error
		250	[145]	KSTR 	  7		55	; slot7 = "Could not find original install dir. Skipping savegame import"
		251	[145]	CALL 	  6	1	2	;  = uv1"log".error(slot7)
		252	[145]	JMP  	  6		5	; 	goto 258
		253	[147]	UGET 	  6		0	; slot6 = uv0"storage"
		254	[147]	MOV  	  7		6	; slot7 = uv0"storage"
		255	[147]	TGETS	  6	6	54	; slot6 = uv0"storage".import_dotnet
		256	[147]	MOV  	  8		5	; slot8 = dir
		257	[147]	CALL 	  6	1	3	;  = uv0"storage".import_dotnet(uv0"storage", dir)
		258	[153]	KSTR 	  5		52	; slot5 = "splash"
		259	[153]	TSETS	  5	0	53	; self.next_item_name = slot5
		260	[154]	TGETS	  5	1	51	; slot5 = params.level
		261	[154]	IST  	   		5	; if params.level
		262	[154]	JMP  	  6		6	; 	goto 269
		263	[154]	TGETS	  5	1	50	; slot5 = params.screen
		264	[154]	IST  	   		5	; if params.screen
		265	[154]	JMP  	  6		3	; 	goto 269
		266	[154]	TGETS	  5	1	49	; slot5 = params.challenge
		267	[154]	ISF  	   		5	; if not params.challenge
		268	[154]	JMP  	  6		121	; 	goto 390
		269	[156]	TGETS	  5	1	48	; slot5 = params.slot
		270	[156]	IST  	   		5	; if params.slot
		271	[156]	JMP  	  6		1	; 	goto 273
		272	[156]	KSHORT	  5		1	; slot5 = 1
		273	[157]	UGET 	  6		0	; slot6 = uv0"storage"
		274	[157]	MOV  	  7		6	; slot7 = uv0"storage"
		275	[157]	TGETS	  6	6	47	; slot6 = uv0"storage".load_slot
		276	[157]	MOV  	  8		5	; slot8 = slot_idx
		277	[157]	CALL 	  6	2	3	; slot6 = uv0"storage".load_slot(uv0"storage", slot_idx)
		278	[157]	IST  	   		6	; if uv0"storage".load_slot
		279	[157]	JMP  	  6		5	; 	goto 285
		280	[157]	UGET 	  6		0	; slot6 = uv0"storage"
		281	[157]	MOV  	  7		6	; slot7 = uv0"storage"
		282	[157]	TGETS	  6	6	46	; slot6 = uv0"storage".create_slot
		283	[157]	MOV  	  8		5	; slot8 = slot_idx
		284	[157]	CALL 	  6	1	3	;  = uv0"storage".create_slot(uv0"storage", slot_idx)
		285	[158]	UGET 	  6		0	; slot6 = uv0"storage"
		286	[158]	MOV  	  7		6	; slot7 = uv0"storage"
		287	[158]	TGETS	  6	6	45	; slot6 = uv0"storage".set_active_slot
		288	[158]	MOV  	  8		5	; slot8 = slot_idx
		289	[158]	CALL 	  6	1	3	;  = uv0"storage".set_active_slot(uv0"storage", slot_idx)
		290	[160]	TGETS	  6	1	50	; slot6 = params.screen
		291	[160]	ISF  	   		6	; if not params.screen
		292	[160]	JMP  	  7		11	; 	goto 304
		293	[161]	TGETS	  6	1	50	; slot6 = params.screen
		294	[161]	TSETS	  6	0	53	; self.next_item_name = params.screen
		295	[162]	TDUP 	  6		42	; slot6 = copy table#k42
		296	[163]	TGETS	  7	1	43	; slot7 = params.custom
		297	[163]	TSETS	  7	6	43	; slot6.custom = params.custom
		298	[164]	TGETS	  7	1	41	; slot7 = params.custom2
		299	[164]	TSETS	  7	6	41	; slot6.custom2 = params.custom2
		300	[165]	TGETS	  7	1	40	; slot7 = params.texture_size
		301	[165]	TSETS	  7	6	40	; slot6.texture_size = params.texture_size
		302	[166]	TSETS	  6	0	44	; self.next_item_args = slot6
		303	[166]	JMP  	  6		86	; 	goto 390
		304	[168]	TGETS	  6	1	51	; slot6 = params.level
		305	[168]	ISF  	   		6	; if not params.level
		306	[168]	JMP  	  7		31	; 	goto 338
		307	[169]	KSTR 	  6		39	; slot6 = "game"
		308	[169]	TSETS	  6	0	53	; self.next_item_name = slot6
		309	[170]	TDUP 	  6		37	; slot6 = copy table#k37
		310	[171]	GGET 	  7		38	; slot7 = _env["tonumber"]
		311	[171]	TGETS	  8	1	51	; slot8 = params.level
		312	[171]	CALL 	  7	2	2	; slot7 = tonumber(params.level)
		313	[171]	TSETS	  7	6	36	; slot6.level_idx = tonumber
		314	[172]	TGETS	  7	1	35	; slot7 = params.mode
		315	[172]	ISF  	   		7	; if not params.mode
		316	[172]	JMP  	  8		5	; 	goto 322
		317	[172]	GGET 	  7		38	; slot7 = _env["tonumber"]
		318	[172]	TGETS	  8	1	35	; slot8 = params.mode
		319	[172]	CALL 	  7	2	2	; slot7 = tonumber(params.mode)
		320	[172]	IST  	   		7	; if tonumber
		321	[172]	JMP  	  8		1	; 	goto 323
		322	[172]	GGET 	  7		34	; slot7 = _env["GAME_MODE_CAMPAIGN"]
		323	[172]	TSETS	  7	6	33	; slot6.level_mode = GAME_MODE_CAMPAIGN
		324	[173]	TGETS	  7	1	32	; slot7 = params.diff
		325	[173]	ISF  	   		7	; if not params.diff
		326	[173]	JMP  	  8		5	; 	goto 332
		327	[173]	GGET 	  7		38	; slot7 = _env["tonumber"]
		328	[173]	TGETS	  8	1	32	; slot8 = params.diff
		329	[173]	CALL 	  7	2	2	; slot7 = tonumber(params.diff)
		330	[173]	IST  	   		7	; if tonumber
		331	[173]	JMP  	  8		1	; 	goto 333
		332	[173]	GGET 	  7		31	; slot7 = _env["DIFFICULTY_NORMAL"]
		333	[173]	TSETS	  7	6	30	; slot6.level_difficulty = DIFFICULTY_NORMAL
		334	[174]	TGETS	  7	1	29	; slot7 = params.extras
		335	[174]	TSETS	  7	6	29	; slot6.extras = params.extras
		336	[175]	TSETS	  6	0	44	; self.next_item_args = slot6
		337	[175]	JMP  	  6		52	; 	goto 390
		338	[176]	TGETS	  6	1	49	; slot6 = params.challenge
		339	[176]	ISF  	   		6	; if not params.challenge
		340	[176]	JMP  	  7		49	; 	goto 390
		341	[177]	TGETS	  6	1	49	; slot6 = params.challenge
		342	[178]	UGET 	  7		7	; slot7 = uv7"RC"
		343	[178]	TGETS	  7	7	28	; slot7 = uv7"RC".v
		344	[178]	TGETS	  7	7	27	; slot7 = uv7"RC".v.challenges
		345	[178]	IST  	   		7	; if uv7"RC".v.challenges
		346	[178]	JMP  	  7		4	; 	goto 351
		347	[179]	UGET 	  7		1	; slot7 = uv1"log"
		348	[179]	TGETS	  7	7	56	; slot7 = uv1"log".error
		349	[179]	KSTR 	  8		26	; slot8 = "challenges are not defined"
		350	[179]	CALL 	  7	1	2	;  = uv1"log".error(slot8)
		351	[181]	KPRI 	  7		1	; slot7 = false
		352	[182]	GGET 	  8		101	; slot8 = _env["pairs"]
		353	[182]	UGET 	  9		7	; slot9 = uv7"RC"
		354	[182]	TGETS	  9	9	28	; slot9 = uv7"RC".v
		355	[182]	TGETS	  9	9	27	; slot9 = uv7"RC".v.challenges
		356	[182]	CALL 	  8	4	2	; slot8, slot9, slot10 = pairs(uv7"RC".v.challenges)
		357	[182]	ISNEXT	 11		19	; Verify ITERN at 377; goto 377
		358	[183]	TGETS	 13	12	25	; slot13 = c.id
		359	[183]	ISNEV	 13		6	; if c.id ~= ch_id
		360	[183]	JMP  	 13		16	; 	goto 377
		361	[184]	UGET 	 13		7	; slot13 = uv7"RC"
		362	[184]	TGETS	 13	13	28	; slot13 = uv7"RC".v
		363	[184]	TGETS	 13	13	27	; slot13 = uv7"RC".v.challenges
		364	[184]	TGETV	 13	13	6	; slot13 = uv7"RC".v.challenges[ch_id]
		365	[185]	KSTR 	 14		39	; slot14 = "game"
		366	[185]	TSETS	 14	0	53	; self.next_item_name = slot14
		367	[186]	TDUP 	 14		24	; slot14 = copy table#k24
		368	[187]	TGETS	 15	12	36	; slot15 = c.level_idx
		369	[187]	TSETS	 15	14	36	; slot14.level_idx = c.level_idx
		370	[188]	TGETS	 15	12	23	; slot15 = c.game_mode
		371	[188]	TSETS	 15	14	33	; slot14.level_mode = c.game_mode
		372	[189]	TSETS	 12	14	22	; slot14.level_challenge = c
		373	[190]	TGETS	 15	12	21	; slot15 = c.difficulty
		374	[190]	TSETS	 15	14	30	; slot14.level_difficulty = c.difficulty
		375	[191]	TSETS	 14	0	44	; self.next_item_args = slot14
		376	[192]	KPRI 	  7		2	; slot7 = true
		377	[182]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		378	[182]	ITERL	 11		-21	; slot10<control> = slot11; if slot11 != nil goto 358
		379	[195]	IST  	   		7	; if found
		380	[195]	JMP  	  8		9	; 	goto 390
		381	[196]	UGET 	  8		1	; slot8 = uv1"log"
		382	[196]	TGETS	  8	8	56	; slot8 = uv1"log".error
		383	[196]	KSTR 	  9		20	; slot9 = "could not find challenge definition for %s"
		384	[196]	MOV  	 10		6	; slot10 = ch_id
		385	[196]	CALL 	  8	1	3	;  = uv1"log".error(slot9, ch_id)
		386	[197]	GGET 	  8		99	; slot8 = _env["love"]
		387	[197]	TGETS	  8	8	19	; slot8 = love.event
		388	[197]	TGETS	  8	8	18	; slot8 = love.event.quit
		389	[197]	CALL 	  8	1	1	;  = love.event.quit()
		390	[203]	GGET 	  5		89	; slot5 = _env["KR_TARGET"]
		391	[203]	ISNES	  5		63	; if KR_TARGET ~= "desktop"
		392	[203]	JMP  	  5		97	; 	goto 490
		393	[203]	GGET 	  5		86	; slot5 = _env["KR_PLATFORM"]
		394	[203]	ISEQS	  5		17	; if KR_PLATFORM == "uwp"
		395	[203]	JMP  	  5		94	; 	goto 490
		396	[205]	TGETS	  5	1	50	; slot5 = params.screen
		397	[205]	ISNES	  5		16	; if params.screen ~= "game_editor"
		398	[205]	JMP  	  5		15	; 	goto 414
		399	[206]	GGET 	  5		99	; slot5 = _env["love"]
		400	[206]	TGETS	  5	5	15	; slot5 = love.mouse
		401	[206]	TGETS	  5	5	14	; slot5 = love.mouse.newCursor
		402	[206]	GGET 	  6		107	; slot6 = _env["KR_PATH_ASSETS_ALL_TARGET"]
		403	[206]	KSTR 	  7		13	; slot7 = "/cursors/crosshair.png"
		404	[206]	CAT  	  6	6	7	; slot6 = KR_PATH_ASSETS_ALL_TARGET .. slot7
		405	[206]	KSHORT	  7		16	; slot7 = 16
		406	[206]	KSHORT	  8		16	; slot8 = 16
		407	[206]	CALL 	  5	2	4	; slot5 = love.mouse.newCursor(slot6, slot7, slot8)
		408	[207]	GGET 	  6		99	; slot6 = _env["love"]
		409	[207]	TGETS	  6	6	15	; slot6 = love.mouse
		410	[207]	TGETS	  6	6	12	; slot6 = love.mouse.setCursor
		411	[207]	MOV  	  7		5	; slot7 = c
		412	[207]	CALL 	  6	1	2	;  = love.mouse.setCursor(c)
		413	[207]	JMP  	  5		76	; 	goto 490
		414	[209]	KSTR 	  5		11	; slot5 = "hand_32"
		415	[210]	TGETS	  6	1	10	; slot6 = params.large_pointer
		416	[210]	ISF  	   		6	; if not params.large_pointer
		417	[210]	JMP  	  7		7	; 	goto 425
		418	[211]	TGETS	  6	1	9	; slot6 = params.height
		419	[211]	KSHORT	  7		1080	; slot7 = 1080
		420	[211]	ISGE 	  6		7	; if params.height >= slot7
		421	[211]	JMP  	  6		2	; 	goto 424
		422	[211]	KSTR 	  5		8	; slot5 = "hand_48"
		423	[211]	JMP  	  6		1	; 	goto 425
		424	[211]	KSTR 	  5		7	; slot5 = "hand_64"
		425	[213]	GGET 	  6		116	; slot6 = _env["IS_TRILOGY"]
		426	[213]	ISF  	   		6	; if not IS_TRILOGY
		427	[213]	JMP  	  7		29	; 	goto 457
		428	[214]	GGET 	  6		99	; slot6 = _env["love"]
		429	[214]	TGETS	  6	6	15	; slot6 = love.mouse
		430	[214]	TGETS	  6	6	14	; slot6 = love.mouse.newCursor
		431	[214]	GGET 	  7		71	; slot7 = _env["string"]
		432	[214]	TGETS	  7	7	5	; slot7 = string.format
		433	[214]	GGET 	  8		107	; slot8 = _env["KR_PATH_ASSETS_ALL_TARGET"]
		434	[214]	KSTR 	  9		4	; slot9 = "/cursors/%s_0001.png"
		435	[214]	CAT  	  8	8	9	; slot8 = KR_PATH_ASSETS_ALL_TARGET .. slot9
		436	[214]	MOV  	  9		5	; slot9 = cursor_name
		437	[214]	CALL 	  7	2	3	; slot7 = string.format(slot8, cursor_name)
		438	[214]	KSHORT	  8		3	; slot8 = 3
		439	[214]	KSHORT	  9		2	; slot9 = 2
		440	[214]	CALL 	  6	2	4	; slot6 = love.mouse.newCursor(string.format, slot8, slot9)
		441	[214]	TSETS	  6	0	6	; self.cursor_up = love.mouse.newCursor
		442	[215]	GGET 	  6		99	; slot6 = _env["love"]
		443	[215]	TGETS	  6	6	15	; slot6 = love.mouse
		444	[215]	TGETS	  6	6	14	; slot6 = love.mouse.newCursor
		445	[215]	GGET 	  7		71	; slot7 = _env["string"]
		446	[215]	TGETS	  7	7	5	; slot7 = string.format
		447	[215]	GGET 	  8		107	; slot8 = _env["KR_PATH_ASSETS_ALL_TARGET"]
		448	[215]	KSTR 	  9		2	; slot9 = "/cursors/%s_0002.png"
		449	[215]	CAT  	  8	8	9	; slot8 = KR_PATH_ASSETS_ALL_TARGET .. slot9
		450	[215]	MOV  	  9		5	; slot9 = cursor_name
		451	[215]	CALL 	  7	2	3	; slot7 = string.format(slot8, cursor_name)
		452	[215]	KSHORT	  8		3	; slot8 = 3
		453	[215]	KSHORT	  9		2	; slot9 = 2
		454	[215]	CALL 	  6	2	4	; slot6 = love.mouse.newCursor(string.format, slot8, slot9)
		455	[215]	TSETS	  6	0	3	; self.cursor_down = love.mouse.newCursor
		456	[215]	JMP  	  6		28	; 	goto 485
		457	[217]	GGET 	  6		99	; slot6 = _env["love"]
		458	[217]	TGETS	  6	6	15	; slot6 = love.mouse
		459	[217]	TGETS	  6	6	14	; slot6 = love.mouse.newCursor
		460	[217]	GGET 	  7		71	; slot7 = _env["string"]
		461	[217]	TGETS	  7	7	5	; slot7 = string.format
		462	[217]	GGET 	  8		103	; slot8 = _env["KR_PATH_ASSETS_GAME_TARGET"]
		463	[217]	KSTR 	  9		1	; slot9 = "/cursors/pointer_%s_0001.png"
		464	[217]	CAT  	  8	8	9	; slot8 = KR_PATH_ASSETS_GAME_TARGET .. slot9
		465	[217]	MOV  	  9		5	; slot9 = cursor_name
		466	[217]	CALL 	  7	2	3	; slot7 = string.format(slot8, cursor_name)
		467	[217]	KSHORT	  8		3	; slot8 = 3
		468	[217]	KSHORT	  9		2	; slot9 = 2
		469	[217]	CALL 	  6	2	4	; slot6 = love.mouse.newCursor(string.format, slot8, slot9)
		470	[217]	TSETS	  6	0	6	; self.cursor_up = love.mouse.newCursor
		471	[218]	GGET 	  6		99	; slot6 = _env["love"]
		472	[218]	TGETS	  6	6	15	; slot6 = love.mouse
		473	[218]	TGETS	  6	6	14	; slot6 = love.mouse.newCursor
		474	[218]	GGET 	  7		71	; slot7 = _env["string"]
		475	[218]	TGETS	  7	7	5	; slot7 = string.format
		476	[218]	GGET 	  8		103	; slot8 = _env["KR_PATH_ASSETS_GAME_TARGET"]
		477	[218]	KSTR 	  9		0	; slot9 = "/cursors/pointer_%s_0002.png"
		478	[218]	CAT  	  8	8	9	; slot8 = KR_PATH_ASSETS_GAME_TARGET .. slot9
		479	[218]	MOV  	  9		5	; slot9 = cursor_name
		480	[218]	CALL 	  7	2	3	; slot7 = string.format(slot8, cursor_name)
		481	[218]	KSHORT	  8		3	; slot8 = 3
		482	[218]	KSHORT	  9		2	; slot9 = 2
		483	[218]	CALL 	  6	2	4	; slot6 = love.mouse.newCursor(string.format, slot8, slot9)
		484	[218]	TSETS	  6	0	3	; self.cursor_down = love.mouse.newCursor
		485	[220]	GGET 	  6		99	; slot6 = _env["love"]
		486	[220]	TGETS	  6	6	15	; slot6 = love.mouse
		487	[220]	TGETS	  6	6	12	; slot6 = love.mouse.setCursor
		488	[220]	TGETS	  7	0	6	; slot7 = self.cursor_up
		489	[220]	CALL 	  6	1	2	;  = love.mouse.setCursor(self.cursor_up)
		490	[224]	RET0 	  0		1	; return
	 78	[ 50]	TSETS	 23	22	74	; director.init = slot23
	 79	[226]	GGET 	 22		99	; slot22 = _env["director"]
	 80	[233]	FNEW 	 23		71	; @./all/director.lua:226-233: 1 args, 3 upvalues, 3 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	signal
		  2:	services
		;;;; variable info ;;;;
		  0-14:	self
		;;;; instructions ;;;;
		  1	[229]	UGET 	  1		0	; slot1 = uv0"log"
		  2	[229]	TGETS	  1	1	4	; slot1 = uv0"log".debug
		  3	[229]	KSTR 	  2		3	; slot2 = "quitting..."
		  4	[229]	CALL 	  1	1	2	;  = uv0"log".debug(slot2)
		  5	[230]	UGET 	  1		1	; slot1 = uv1"signal"
		  6	[230]	TGETS	  1	1	2	; slot1 = uv1"signal".emit
		  7	[230]	KSTR 	  2		1	; slot2 = "quit"
		  8	[230]	CALL 	  1	1	2	;  = uv1"signal".emit(slot2)
		  9	[231]	UGET 	  1		2	; slot1 = uv2"services"
		 10	[231]	MOV  	  2		1	; slot2 = uv2"services"
		 11	[231]	TGETS	  1	1	0	; slot1 = uv2"services".shutdown
		 12	[231]	CALL 	  1	1	2	;  = uv2"services".shutdown(uv2"services")
		 13	[232]	KPRI 	  1		1	; slot1 = false
		 14	[232]	RET1 	  1		2	; return slot1
	 81	[226]	TSETS	 23	22	72	; director.on_quit = slot23
	 82	[235]	GGET 	 22		99	; slot22 = _env["director"]
	 83	[246]	FNEW 	 23		69	; @./all/director.lua:235-246: 4 args, 1 upvalues, 15 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-47:	self
		  0-47:	item_name
		  0-47:	ref_res
		  0-47:	forced_texture_size
		  7-47:	tsize
		  18-47:	ftsize
		  24-47:	scale
		  29-47:	factors
		;;;; instructions ;;;;
		  1	[236]	GGET 	  4		8	; slot4 = _env["string"]
		  2	[236]	TGETS	  4	4	7	; slot4 = string.split
		  3	[236]	TGETS	  5	0	6	; slot5 = self.params
		  4	[236]	TGETS	  5	5	5	; slot5 = self.params.texture_size
		  5	[236]	KSTR 	  6		4	; slot6 = "_"
		  6	[236]	CALL 	  4	2	3	; slot4 = string.split(self.params.texture_size, slot6)
		  7	[236]	TGETB	  4	4	1	; slot4 = string.split[1]
		  8	[237]	ISF  	   		3	; if not forced_texture_size
		  9	[237]	JMP  	  5		8	; 	goto 18
		 10	[237]	GGET 	  5		8	; slot5 = _env["string"]
		 11	[237]	TGETS	  5	5	7	; slot5 = string.split
		 12	[237]	MOV  	  6		3	; slot6 = forced_texture_size
		 13	[237]	KSTR 	  7		4	; slot7 = "_"
		 14	[237]	CALL 	  5	2	3	; slot5 = string.split(forced_texture_size, slot7)
		 15	[237]	TGETB	  5	5	1	; slot5 = string.split[1]
		 16	[237]	IST  	   		5	; if slot5
		 17	[237]	JMP  	  6		1	; 	goto 19
		 18	[237]	KPRI 	  5		0	; slot5 = nil
		 19	[238]	GGET 	  6		3	; slot6 = _env["TEXTURE_SIZE_ALIAS"]
		 20	[238]	ISTC 	  7		5	; slot7 = ftsize; if ftsize
		 21	[238]	JMP  	  7		1	; 	goto 23
		 22	[238]	MOV  	  7		4	; slot7 = tsize
		 23	[238]	TGETV	  6	6	7	; slot6 = TEXTURE_SIZE_ALIAS[tsize]
		 24	[238]	DIVVV	  6	2	6	; slot6 = ref_res / slot6
		 25	[239]	GGET 	  7		2	; slot7 = _env["TEXTURE_SIZE_FACTOR"]
		 26	[239]	ISTC 	  8		5	; slot8 = ftsize; if ftsize
		 27	[239]	JMP  	  8		1	; 	goto 29
		 28	[239]	MOV  	  8		4	; slot8 = tsize
		 29	[239]	TGETV	  7	7	8	; slot7 = TEXTURE_SIZE_FACTOR[tsize]
		 30	[240]	ISF  	   		7	; if not factors
		 31	[240]	JMP  	  8		5	; 	goto 37
		 32	[240]	TGETV	  8	7	1	; slot8 = factors[item_name]
		 33	[240]	ISF  	   		8	; if not slot8
		 34	[240]	JMP  	  9		2	; 	goto 37
		 35	[241]	TGETV	  8	7	1	; slot8 = factors[item_name]
		 36	[241]	DIVVV	  6	6	8	; slot6 = scale / slot8
		 37	[243]	UGET 	  8		0	; slot8 = uv0"log"
		 38	[243]	TGETS	  8	8	1	; slot8 = uv0"log".debug
		 39	[243]	KSTR 	  9		0	; slot9 = "item:%s ref_res:%s texture_size:%s forced_texture_size:%s-> scale:%s"
		 40	[244]	MOV  	 10		1	; slot10 = item_name
		 41	[244]	MOV  	 11		2	; slot11 = ref_res
		 42	[244]	TGETS	 12	0	6	; slot12 = self.params
		 43	[244]	TGETS	 12	12	5	; slot12 = self.params.texture_size
		 44	[244]	MOV  	 13		3	; slot13 = forced_texture_size
		 45	[244]	MOV  	 14		6	; slot14 = scale
		 46	[243]	CALL 	  8	1	7	;  = uv0"log".debug(slot9, item_name, ref_res, self.params.texture_size, forced_texture_size, scale)
		 47	[245]	RET1 	  6		2	; return scale
	 84	[235]	TSETS	 23	22	70	; director.get_texture_scale = slot23
	 85	[248]	GGET 	 22		99	; slot22 = _env["director"]
	 86	[256]	FNEW 	 23		67	; @./all/director.lua:248-256: 2 args, 0 upvalues, 6 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-19:	self
		  0-19:	comic_idx
		  5-19:	suffix
		  8-19:	file
		;;;; instructions ;;;;
		  1	[249]	GGET 	  2		7	; slot2 = _env["string"]
		  2	[249]	TGETS	  2	2	6	; slot2 = string.format
		  3	[249]	KSTR 	  3		5	; slot3 = "/data/comics/%02i.csv"
		  4	[249]	MOV  	  4		1	; slot4 = comic_idx
		  5	[249]	CALL 	  2	2	3	; slot2 = string.format(slot3, comic_idx)
		  6	[250]	GGET 	  3		4	; slot3 = _env["KR_PATH_GAME_TARGET"]
		  7	[250]	MOV  	  4		2	; slot4 = suffix
		  8	[250]	CAT  	  3	3	4	; slot3 = KR_PATH_GAME_TARGET .. suffix
		  9	[251]	GGET 	  4		3	; slot4 = _env["love"]
		 10	[251]	TGETS	  4	4	2	; slot4 = love.filesystem
		 11	[251]	TGETS	  4	4	1	; slot4 = love.filesystem.isFile
		 12	[251]	MOV  	  5		3	; slot5 = file
		 13	[251]	CALL 	  4	2	2	; slot4 = love.filesystem.isFile(file)
		 14	[251]	IST  	   		4	; if love.filesystem.isFile
		 15	[251]	JMP  	  4		3	; 	goto 19
		 16	[253]	GGET 	  4		0	; slot4 = _env["KR_PATH_GAME"]
		 17	[253]	MOV  	  5		2	; slot5 = suffix
		 18	[253]	CAT  	  3	4	5	; slot3 = KR_PATH_GAME .. suffix
		 19	[255]	RET1 	  3		2	; return file
	 87	[248]	TSETS	 23	22	68	; director.get_comic_data_file = slot23
	 88	[258]	GGET 	 22		99	; slot22 = _env["director"]
	 89	[297]	FNEW 	 23		65	; @./all/director.lua:258-297: 2 args, 1 upvalues, 17 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-69:	self
		  0-69:	force_scissor
		  1-69:	params
		  5-69:	aw
		  5-69:	ah
		  11-69:	screen_aspect
		  12-69:	max_aspect
		  13-69:	min_aspect
		;;;; instructions ;;;;
		  1	[259]	TGETS	  2	0	15	; slot2 = self.params
		  2	[262]	GGET 	  3		14	; slot3 = _env["love"]
		  3	[262]	TGETS	  3	3	13	; slot3 = love.graphics
		  4	[262]	TGETS	  3	3	12	; slot3 = love.graphics.getDimensions
		  5	[262]	CALL 	  3	3	1	; slot3, slot4 = love.graphics.getDimensions()
		  6	[263]	MOV  	  5		3	; slot5 = aw
		  7	[263]	TSETS	  4	2	10	; params.height = ah
		  8	[263]	TSETS	  5	2	11	; params.width = aw
		  9	[266]	TGETS	  5	2	11	; slot5 = params.width
		 10	[266]	TGETS	  6	2	10	; slot6 = params.height
		 11	[266]	DIVVV	  5	5	6	; slot5 = params.width / params.height
		 12	[267]	GGET 	  6		9	; slot6 = _env["MAX_SCREEN_ASPECT"]
		 13	[268]	GGET 	  7		8	; slot7 = _env["MIN_SCREEN_ASPECT"]
		 14	[270]	ISGE 	  5		7	; if screen_aspect >= min_aspect
		 15	[270]	JMP  	  8		15	; 	goto 31
		 16	[272]	TGETS	  8	2	11	; slot8 = params.width
		 17	[272]	TSETS	  8	0	7	; self.scissor_w = params.width
		 18	[273]	TGETS	  8	2	11	; slot8 = params.width
		 19	[273]	DIVVV	  8	8	7	; slot8 = params.width / min_aspect
		 20	[273]	TSETS	  8	0	6	; self.scissor_h = slot8
		 21	[274]	KSHORT	  8		0	; slot8 = 0
		 22	[274]	TSETS	  8	0	5	; self.scissor_x = slot8
		 23	[275]	TGETS	  8	2	10	; slot8 = params.height
		 24	[275]	TGETS	  9	0	6	; slot9 = self.scissor_h
		 25	[275]	SUBVV	  8	8	9	; slot8 = params.height - self.scissor_h
		 26	[275]	DIVVN	  8	8	0	; slot8 = slot8 / 2
		 27	[275]	TSETS	  8	0	4	; self.scissor_y = slot8
		 28	[276]	KPRI 	  8		2	; slot8 = true
		 29	[276]	TSETS	  8	0	3	; self.scissor_enabled = slot8
		 30	[276]	JMP  	  8		19	; 	goto 50
		 31	[278]	ISGE 	  6		5	; if max_aspect >= screen_aspect
		 32	[278]	JMP  	  8		15	; 	goto 48
		 33	[280]	TGETS	  8	2	10	; slot8 = params.height
		 34	[280]	MULVV	  8	8	6	; slot8 = params.height * max_aspect
		 35	[280]	TSETS	  8	0	7	; self.scissor_w = slot8
		 36	[281]	TGETS	  8	2	10	; slot8 = params.height
		 37	[281]	TSETS	  8	0	6	; self.scissor_h = params.height
		 38	[282]	TGETS	  8	2	11	; slot8 = params.width
		 39	[282]	TGETS	  9	0	7	; slot9 = self.scissor_w
		 40	[282]	SUBVV	  8	8	9	; slot8 = params.width - self.scissor_w
		 41	[282]	DIVVN	  8	8	0	; slot8 = slot8 / 2
		 42	[282]	TSETS	  8	0	5	; self.scissor_x = slot8
		 43	[283]	KSHORT	  8		0	; slot8 = 0
		 44	[283]	TSETS	  8	0	4	; self.scissor_y = slot8
		 45	[284]	KPRI 	  8		2	; slot8 = true
		 46	[284]	TSETS	  8	0	3	; self.scissor_enabled = slot8
		 47	[284]	JMP  	  8		2	; 	goto 50
		 48	[287]	KPRI 	  8		1	; slot8 = false
		 49	[287]	TSETS	  8	0	3	; self.scissor_enabled = slot8
		 50	[290]	ISEQP	  1		0	; if force_scissor == nil
		 51	[290]	JMP  	  8		6	; 	goto 58
		 52	[291]	UGET 	  8		0	; slot8 = uv0"log"
		 53	[291]	TGETS	  8	8	2	; slot8 = uv0"log".info
		 54	[291]	KSTR 	  9		1	; slot9 = "forcing scissor value to %s"
		 55	[291]	MOV  	 10		1	; slot10 = force_scissor
		 56	[291]	CALL 	  8	1	3	;  = uv0"log".info(slot9, force_scissor)
		 57	[292]	TSETS	  1	0	3	; self.scissor_enabled = force_scissor
		 58	[295]	UGET 	  8		0	; slot8 = uv0"log"
		 59	[295]	TGETS	  8	8	2	; slot8 = uv0"log".info
		 60	[295]	KSTR 	  9		0	; slot9 = "resetting screen params. w,h:%s,%s scissor:%s %s,%s,%s,%s"
		 61	[296]	MOV  	 10		3	; slot10 = aw
		 62	[296]	MOV  	 11		4	; slot11 = ah
		 63	[296]	TGETS	 12	0	3	; slot12 = self.scissor_enabled
		 64	[296]	TGETS	 13	0	5	; slot13 = self.scissor_x
		 65	[296]	TGETS	 14	0	4	; slot14 = self.scissor_y
		 66	[296]	TGETS	 15	0	7	; slot15 = self.scissor_w
		 67	[296]	TGETS	 16	0	6	; slot16 = self.scissor_h
		 68	[295]	CALL 	  8	1	9	;  = uv0"log".info(slot9, aw, ah, self.scissor_enabled, self.scissor_x, self.scissor_y, self.scissor_w, self.scissor_h)
		 69	[297]	RET0 	  0		1	; return
	 90	[258]	TSETS	 23	22	66	; director.reset_screen_params = slot23
	 91	[300]	GGET 	 22		99	; slot22 = _env["director"]
	 92	[379]	FNEW 	 23		63	; @./all/director.lua:300-379: 3 args, 7 upvalues, 9 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	ISM
		  2:	PP
		  3:	services
		  4:	marketing
		  5:	storage
		  6:	features
		;;;; variable info ;;;;
		  0-190:	self
		  0-190:	item_name
		  0-190:	outcome
		  29-50:	w
		  106-113:	global
		  152-190:	props
		  158-189:	props_next
		;;;; instructions ;;;;
		  1	[302]	TGETS	  3	0	44	; slot3 = self.active_item
		  2	[302]	ISF  	   		3	; if not self.active_item
		  3	[302]	JMP  	  4		9	; 	goto 13
		  4	[302]	TGETS	  3	0	44	; slot3 = self.active_item
		  5	[302]	TGETS	  3	3	43	; slot3 = self.active_item.done_callback_called
		  6	[302]	ISF  	   		3	; if not self.active_item.done_callback_called
		  7	[302]	JMP  	  4		5	; 	goto 13
		  8	[303]	UGET 	  3		0	; slot3 = uv0"log"
		  9	[303]	TGETS	  3	3	42	; slot3 = uv0"log".error
		 10	[303]	KSTR 	  4		41	; slot4 = "  Done callback already called... Ignoring!"
		 11	[303]	CALL 	  3	1	2	;  = uv0"log".error(slot4)
		 12	[304]	RET0 	  0		1	; return
		 13	[306]	TGETS	  3	0	44	; slot3 = self.active_item
		 14	[306]	KPRI 	  4		2	; slot4 = true
		 15	[306]	TSETS	  4	3	43	; self.active_item.done_callback_called = slot4
		 16	[309]	TGETS	  3	0	44	; slot3 = self.active_item
		 17	[309]	ISF  	   		3	; if not self.active_item
		 18	[309]	JMP  	  4		32	; 	goto 51
		 19	[310]	TGETS	  3	0	44	; slot3 = self.active_item
		 20	[310]	TGETS	  3	3	40	; slot3 = self.active_item.game_gui
		 21	[310]	ISF  	   		3	; if not self.active_item.game_gui
		 22	[310]	JMP  	  4		5	; 	goto 28
		 23	[310]	TGETS	  3	0	44	; slot3 = self.active_item
		 24	[310]	TGETS	  3	3	40	; slot3 = self.active_item.game_gui
		 25	[310]	TGETS	  3	3	39	; slot3 = self.active_item.game_gui.window
		 26	[310]	IST  	   		3	; if self.active_item.game_gui.window
		 27	[310]	JMP  	  4		2	; 	goto 30
		 28	[310]	TGETS	  3	0	44	; slot3 = self.active_item
		 29	[310]	TGETS	  3	3	39	; slot3 = self.active_item.window
		 30	[311]	ISF  	   		3	; if not w
		 31	[311]	JMP  	  4		19	; 	goto 51
		 32	[312]	UGET 	  4		0	; slot4 = uv0"log"
		 33	[312]	TGETS	  4	4	38	; slot4 = uv0"log".debug
		 34	[312]	KSTR 	  5		37	; slot5 = "disabling events for item:%s window:%s"
		 35	[312]	TGETS	  6	0	44	; slot6 = self.active_item
		 36	[312]	TGETS	  6	6	36	; slot6 = self.active_item.item_name
		 37	[312]	MOV  	  7		3	; slot7 = w
		 38	[312]	CALL 	  4	1	4	;  = uv0"log".debug(slot5, self.active_item.item_name, w)
		 39	[313]	MOV  	  5		3	; slot5 = w
		 40	[313]	TGETS	  4	3	35	; slot4 = w.disable
		 41	[313]	KPRI 	  6		1	; slot6 = false
		 42	[313]	CALL 	  4	1	3	;  = w.disable(w, slot6)
		 43	[314]	UGET 	  4		1	; slot4 = uv1"ISM"
		 44	[314]	ISF  	   		4	; if not uv1"ISM"
		 45	[314]	JMP  	  5		5	; 	goto 51
		 46	[314]	UGET 	  4		1	; slot4 = uv1"ISM"
		 47	[314]	MOV  	  5		4	; slot5 = uv1"ISM"
		 48	[314]	TGETS	  4	4	34	; slot4 = uv1"ISM".destroy
		 49	[314]	MOV  	  6		3	; slot6 = w
		 50	[314]	CALL 	  4	1	3	;  = uv1"ISM".destroy(uv1"ISM", w)
		 51	[318]	UGET 	  3		0	; slot3 = uv0"log"
		 52	[318]	TGETS	  3	3	38	; slot3 = uv0"log".debug
		 53	[318]	KSTR 	  4		33	; slot4 = "DONE CALLBACK FROM %s with outcome %s"
		 54	[318]	MOV  	  5		1	; slot5 = item_name
		 55	[318]	GGET 	  6		32	; slot6 = _env["getdump"]
		 56	[318]	MOV  	  7		2	; slot7 = outcome
		 57	[318]	CALL 	  6	0	2	; MULTRES = getdump(outcome)
		 58	[318]	CALLM	  3	1	2	;  = uv0"log".debug(slot4, item_name, ...MULTRES)
		 59	[320]	ISF  	   		2	; if not outcome
		 60	[320]	JMP  	  3		72	; 	goto 133
		 61	[321]	TGETS	  3	2	31	; slot3 = outcome.quit
		 62	[321]	ISF  	   		3	; if not outcome.quit
		 63	[321]	JMP  	  4		6	; 	goto 70
		 64	[322]	GGET 	  3		30	; slot3 = _env["love"]
		 65	[322]	TGETS	  3	3	29	; slot3 = love.event
		 66	[322]	TGETS	  3	3	31	; slot3 = love.event.quit
		 67	[322]	CALL 	  3	1	1	;  = love.event.quit()
		 68	[323]	RET0 	  0		1	; return
		 69	[323]	JMP  	  3		13	; 	goto 83
		 70	[324]	TGETS	  3	2	28	; slot3 = outcome.next_item_name
		 71	[324]	ISF  	   		3	; if not outcome.next_item_name
		 72	[324]	JMP  	  4		5	; 	goto 78
		 73	[325]	TGETS	  3	2	28	; slot3 = outcome.next_item_name
		 74	[325]	TSETS	  3	0	28	; self.next_item_name = outcome.next_item_name
		 75	[326]	TSETS	  2	0	27	; self.next_item_args = outcome
		 76	[327]	RET0 	  0		1	; return
		 77	[327]	JMP  	  3		5	; 	goto 83
		 78	[328]	TGETS	  3	2	26	; slot3 = outcome.prevent_loading
		 79	[328]	ISF  	   		3	; if not outcome.prevent_loading
		 80	[328]	JMP  	  4		2	; 	goto 83
		 81	[329]	KPRI 	  3		2	; slot3 = true
		 82	[329]	TSETS	  3	0	25	; self.next_item_prevent_loading = slot3
		 83	[333]	TGETS	  3	2	24	; slot3 = outcome.privacy_policy_accepted
		 84	[333]	ISF  	   		3	; if not outcome.privacy_policy_accepted
		 85	[333]	JMP  	  4		14	; 	goto 100
		 86	[334]	UGET 	  3		2	; slot3 = uv2"PP"
		 87	[334]	MOV  	  4		3	; slot4 = uv2"PP"
		 88	[334]	TGETS	  3	3	23	; slot3 = uv2"PP".give_consent_with_age
		 89	[334]	TGETS	  5	2	22	; slot5 = outcome.birth_month
		 90	[334]	TGETS	  6	2	21	; slot6 = outcome.birth_year
		 91	[334]	CALL 	  3	1	4	;  = uv2"PP".give_consent_with_age(uv2"PP", outcome.birth_month, outcome.birth_year)
		 92	[335]	UGET 	  3		3	; slot3 = uv3"services"
		 93	[335]	MOV  	  4		3	; slot4 = uv3"services"
		 94	[335]	TGETS	  3	3	20	; slot3 = uv3"services".init
		 95	[335]	CALL 	  3	1	2	;  = uv3"services".init(uv3"services")
		 96	[336]	UGET 	  3		4	; slot3 = uv4"marketing"
		 97	[336]	MOV  	  4		3	; slot4 = uv4"marketing"
		 98	[336]	TGETS	  3	3	20	; slot3 = uv4"marketing".init
		 99	[336]	CALL 	  3	1	2	;  = uv4"marketing".init(uv4"marketing")
		100	[340]	TGETS	  3	2	19	; slot3 = outcome.simple_privacy_policy_accepted
		101	[340]	ISF  	   		3	; if not outcome.simple_privacy_policy_accepted
		102	[340]	JMP  	  4		11	; 	goto 114
		103	[342]	UGET 	  3		5	; slot3 = uv5"storage"
		104	[342]	MOV  	  4		3	; slot4 = uv5"storage"
		105	[342]	TGETS	  3	3	18	; slot3 = uv5"storage".load_global
		106	[342]	CALL 	  3	2	2	; slot3 = uv5"storage".load_global(uv5"storage")
		107	[343]	KPRI 	  4		2	; slot4 = true
		108	[343]	TSETS	  4	3	19	; global.simple_privacy_policy_accepted = slot4
		109	[344]	UGET 	  4		5	; slot4 = uv5"storage"
		110	[344]	MOV  	  5		4	; slot5 = uv5"storage"
		111	[344]	TGETS	  4	4	17	; slot4 = uv5"storage".save_global
		112	[344]	MOV  	  6		3	; slot6 = global
		113	[344]	CALL 	  4	1	3	;  = uv5"storage".save_global(uv5"storage", global)
		114	[348]	TGETS	  3	2	16	; slot3 = outcome.splash_done
		115	[348]	ISF  	   		3	; if not outcome.splash_done
		116	[348]	JMP  	  4		16	; 	goto 133
		117	[348]	UGET 	  3		6	; slot3 = uv6"features"
		118	[348]	TGETS	  3	3	15	; slot3 = uv6"features".delay_services_init
		119	[348]	ISF  	   		3	; if not uv6"features".delay_services_init
		120	[348]	JMP  	  4		12	; 	goto 133
		121	[348]	UGET 	  3		6	; slot3 = uv6"features"
		122	[348]	TGETS	  3	3	14	; slot3 = uv6"features".requires_privacy_policy
		123	[348]	IST  	   		3	; if uv6"features".requires_privacy_policy
		124	[348]	JMP  	  3		8	; 	goto 133
		125	[350]	UGET 	  3		3	; slot3 = uv3"services"
		126	[350]	MOV  	  4		3	; slot4 = uv3"services"
		127	[350]	TGETS	  3	3	20	; slot3 = uv3"services".init
		128	[350]	CALL 	  3	1	2	;  = uv3"services".init(uv3"services")
		129	[351]	UGET 	  3		4	; slot3 = uv4"marketing"
		130	[351]	MOV  	  4		3	; slot4 = uv4"marketing"
		131	[351]	TGETS	  3	3	20	; slot3 = uv4"marketing".init
		132	[351]	CALL 	  3	1	2	;  = uv4"marketing".init(uv4"marketing")
		133	[355]	ISNES	  1		13	; if item_name ~= "comics"
		134	[355]	JMP  	  3		16	; 	goto 151
		135	[357]	UGET 	  3		0	; slot3 = uv0"log"
		136	[357]	TGETS	  3	3	12	; slot3 = uv0"log".end_time
		137	[357]	GGET 	  4		11	; slot4 = _env["string"]
		138	[357]	TGETS	  4	4	10	; slot4 = string.format
		139	[357]	KSTR 	  5		9	; slot5 = "comic/%02i"
		140	[357]	TGETS	  6	0	44	; slot6 = self.active_item
		141	[357]	TGETS	  6	6	8	; slot6 = self.active_item.comic_idx
		142	[357]	IST  	   		6	; if self.active_item.comic_idx
		143	[357]	JMP  	  7		1	; 	goto 145
		144	[357]	KSHORT	  6		0	; slot6 = 0
		145	[357]	CALL 	  4	0	3	; MULTRES = string.format(slot5, slot6)
		146	[357]	CALLM	  3	1	0	;  = uv0"log".end_time(, ...MULTRES)
		147	[358]	TGETS	  3	0	44	; slot3 = self.active_item
		148	[358]	TGETS	  3	3	6	; slot3 = self.active_item.game_item
		149	[358]	TSETS	  3	0	7	; self.queued_item = self.active_item.game_item
		150	[359]	RET0 	  0		1	; return
		151	[362]	TGETS	  3	0	5	; slot3 = self.item_props
		152	[362]	TGETV	  3	3	1	; slot3 = self.item_props[item_name]
		153	[364]	TGETS	  4	3	4	; slot4 = props.next
		154	[364]	ISF  	   		4	; if not props.next
		155	[364]	JMP  	  5		34	; 	goto 190
		156	[365]	TGETS	  4	0	5	; slot4 = self.item_props
		157	[365]	TGETS	  5	3	4	; slot5 = props.next
		158	[365]	TGETV	  4	4	5	; slot4 = self.item_props[props.next]
		159	[367]	ISF  	   		4	; if not props_next
		160	[367]	JMP  	  5		24	; 	goto 185
		161	[367]	TGETS	  5	4	3	; slot5 = props_next.skip_check
		162	[368]	ISF  	   		5	; if not props_next.skip_check
		163	[368]	JMP  	  6		21	; 	goto 185
		164	[368]	GGET 	  5		2	; slot5 = _env["director"]
		165	[368]	TGETS	  5	5	1	; slot5 = director.skip_checks
		166	[368]	TGETS	  6	4	3	; slot6 = props_next.skip_check
		167	[368]	TGETV	  5	5	6	; slot5 = director.skip_checks[props_next.skip_check]
		168	[369]	ISF  	   		5	; if not slot5
		169	[369]	JMP  	  6		15	; 	goto 185
		170	[369]	GGET 	  5		2	; slot5 = _env["director"]
		171	[369]	TGETS	  5	5	1	; slot5 = director.skip_checks
		172	[369]	TGETS	  6	4	3	; slot6 = props_next.skip_check
		173	[369]	TGETV	  5	5	6	; slot5 = director.skip_checks[props_next.skip_check]
		174	[369]	CALL 	  5	2	1	; slot5 = slot5()
		175	[369]	ISF  	   		5	; if not slot5
		176	[369]	JMP  	  6		8	; 	goto 185
		177	[371]	UGET 	  5		0	; slot5 = uv0"log"
		178	[371]	TGETS	  5	5	38	; slot5 = uv0"log".debug
		179	[371]	KSTR 	  6		0	; slot6 = "skipping screen %s. %s passed"
		180	[371]	TGETS	  7	3	4	; slot7 = props.next
		181	[371]	TGETS	  8	4	3	; slot8 = props_next.skip_check
		182	[371]	CALL 	  5	1	4	;  = uv0"log".debug(slot6, props.next, props_next.skip_check)
		183	[372]	MOV  	  3		4	; slot3 = props_next
		184	[373]	JMP  	  4		-32	; 	goto 153
		185	[375]	TGETS	  5	3	4	; slot5 = props.next
		186	[375]	TSETS	  5	0	28	; self.next_item_name = props.next
		187	[376]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		188	[376]	TSETS	  5	0	27	; self.next_item_args = slot5
		189	[377]	RET0 	  0		1	; return
		190	[379]	RET0 	  0		1	; return
	 93	[300]	TSETS	 23	22	64	; director.item_done_callback = slot23
	 94	[381]	GGET 	 22		99	; slot22 = _env["director"]
	 95	[577]	FNEW 	 23		61	; @./all/director.lua:381-577: 3 args, 5 upvalues, 19 slots
		
		;;;; constant tables ;;;;
		ktable#0 = [
			[type] = sound,
			]
		
		
		ktable#2 = [
			[type] = atlas,
			]
		
		
		ktable#11 = [
			[type] = sound,
			]
		
		
		ktable#12 = [
			[type] = sound,
			]
		
		
		ktable#13 = [
			[type] = sound,
			]
		
		
		ktable#14 = [
			[type] = sound,
			]
		
		
		ktable#16 = [
			[type] = sound,
			]
		
		
		ktable#21 = [
			[atlas_name] = temp_game_texts,
			[type] = atlas,
			]
		
		
		ktable#22 = [
			[item_name] = game,
			[type] = groups,
			]
		
		
		ktable#50 = [
			[item_name] = game_gui,
			[type] = groups,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	S
		  1:	I
		  2:	log
		  3:	replace_locale
		  4:	storage
		;;;; variable info ;;;;
		  0-411:	self
		  0-411:	item
		  0-411:	postponed
		  1-411:	unload
		  2-411:	postpone
		  21-411:	list
		  25-349:	game
		  42-349:	groups
		  68-78:	<generator>
		  68-78:	<state>
		  68-78:	<control>
		  69-76:	_
		  69-76:	hero_name
		  95-349:	slot
		  112-128:	<generator>
		  112-128:	<state>
		  112-128:	<control>
		  113-126:	_
		  113-126:	tower
		  118-126:	tower_name
		  121-126:	tower_texture
		  137-147:	<generator>
		  137-147:	<state>
		  137-147:	<control>
		  138-145:	_
		  138-145:	tower
		  152-162:	<generator>
		  152-162:	<state>
		  152-162:	<control>
		  153-160:	_
		  153-160:	tower
		  173-183:	<generator>
		  173-183:	<state>
		  173-183:	<control>
		  174-181:	_
		  174-181:	item
		  198-208:	<generator>
		  198-208:	<state>
		  198-208:	<control>
		  199-206:	_
		  199-206:	pow
		  213-223:	<generator>
		  213-223:	<state>
		  213-223:	<control>
		  214-221:	_
		  214-221:	pow
		  248-257:	<generator>
		  248-257:	<state>
		  248-257:	<control>
		  249-255:	_
		  249-255:	group
		  267-276:	<generator>
		  267-276:	<state>
		  267-276:	<control>
		  268-274:	_
		  268-274:	group
		  284-293:	<generator>
		  284-293:	<state>
		  284-293:	<control>
		  285-291:	_
		  285-291:	hero_name
		  317-329:	<generator>
		  317-329:	<state>
		  317-329:	<control>
		  318-327:	_
		  318-327:	item
		  354-409:	textures
		  361-377:	scale
		  367-377:	<generator>
		  367-377:	<state>
		  367-377:	<control>
		  368-375:	_
		  368-375:	group
		  383-392:	<generator>
		  383-392:	<state>
		  383-392:	<control>
		  384-390:	_
		  384-390:	group
		;;;; instructions ;;;;
		  1	[393]	FNEW 	  3		60	; @./all/director.lua:383-393: 1 args, 3 upvalues, 12 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			  0:	S
			  1:	self
			  2:	I
			;;;; variable info ;;;;
			  0-37:	list
			  3-36:	<generator>
			  3-36:	<state>
			  3-36:	<control>
			  4-34:	_
			  4-34:	row
			;;;; instructions ;;;;
			  1	[384]	GGET 	  1		13	; slot1 = _env["pairs"]
			  2	[384]	MOV  	  2		0	; slot2 = list
			  3	[384]	CALL 	  1	4	2	; slot1, slot2, slot3 = pairs(list)
			  4	[384]	ISNEXT	  4		30	; Verify ITERN at 35; goto 35
			  5	[385]	TGETS	  6	5	12	; slot6 = row.type
			  6	[385]	ISNES	  6		11	; if row.type ~= "sound"
			  7	[385]	JMP  	  6		6	; 	goto 14
			  8	[386]	UGET 	  6		0	; slot6 = uv0"S"
			  9	[386]	MOV  	  7		6	; slot7 = uv0"S"
			 10	[386]	TGETS	  6	6	10	; slot6 = uv0"S".unload_group
			 11	[386]	TGETS	  8	5	9	; slot8 = row.group
			 12	[386]	CALL 	  6	1	3	;  = uv0"S".unload_group(uv0"S", row.group)
			 13	[386]	JMP  	  6		21	; 	goto 35
			 14	[387]	TGETS	  6	5	12	; slot6 = row.type
			 15	[387]	ISNES	  6		8	; if row.type ~= "groups"
			 16	[387]	JMP  	  6		9	; 	goto 26
			 17	[388]	UGET 	  6		1	; slot6 = uv1"self"
			 18	[388]	MOV  	  7		6	; slot7 = uv1"self"
			 19	[388]	TGETS	  6	6	7	; slot6 = uv1"self".unload_texture_groups
			 20	[388]	TGETS	  8	5	8	; slot8 = row.groups
			 21	[388]	TGETS	  9	5	6	; slot9 = row.texture_size
			 22	[388]	TGETS	 10	5	5	; slot10 = row.ref_res
			 23	[388]	TGETS	 11	5	4	; slot11 = row.item_name
			 24	[388]	CALL 	  6	1	6	;  = uv1"self".unload_texture_groups(uv1"self", row.groups, row.texture_size, row.ref_res, row.item_name)
			 25	[388]	JMP  	  6		9	; 	goto 35
			 26	[389]	TGETS	  6	5	12	; slot6 = row.type
			 27	[389]	ISNES	  6		3	; if row.type ~= "atlas"
			 28	[389]	JMP  	  6		6	; 	goto 35
			 29	[390]	UGET 	  6		2	; slot6 = uv2"I"
			 30	[390]	MOV  	  7		6	; slot7 = uv2"I"
			 31	[390]	TGETS	  6	6	2	; slot6 = uv2"I".unload_atlas
			 32	[390]	TGETS	  8	5	1	; slot8 = row.atlas_name
			 33	[390]	TGETS	  9	5	0	; slot9 = row.scale
			 34	[390]	CALL 	  6	1	4	;  = uv2"I".unload_atlas(uv2"I", row.atlas_name, row.scale)
			 35	[384]	ITERN	  4	3	3	; slot4, slot5, slot6 = slot1<generator>, slot2<state>, slot3<control>; slot4, slot5 = slot1<generator>(slot2<state>, slot3<control>)
			 36	[384]	ITERL	  4		-32	; slot3<control> = slot4; if slot4 != nil goto 5
			 37	[393]	RET0 	  0		1	; return
		  2	[400]	FNEW 	  4		59	; @./all/director.lua:394-400: 1 args, 1 upvalues, 4 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			  0:	self
			;;;; variable info ;;;;
			  0-14:	list
			;;;; instructions ;;;;
			  1	[396]	UGET 	  1		0	; slot1 = uv0"self"
			  2	[396]	TGETS	  1	1	2	; slot1 = uv0"self".pending_unloads
			  3	[396]	IST  	   		1	; if uv0"self".pending_unloads
			  4	[396]	JMP  	  1		3	; 	goto 8
			  5	[397]	UGET 	  1		0	; slot1 = uv0"self"
			  6	[397]	TNEW 	  2		0	; slot2 = new table( array: 0, dict: 1)
			  7	[397]	TSETS	  2	1	2	; uv0"self".pending_unloads = slot2
			  8	[399]	GGET 	  1		1	; slot1 = _env["table"]
			  9	[399]	TGETS	  1	1	0	; slot1 = table.merge
			 10	[399]	UGET 	  2		0	; slot2 = uv0"self"
			 11	[399]	TGETS	  2	2	2	; slot2 = uv0"self".pending_unloads
			 12	[399]	MOV  	  3		0	; slot3 = list
			 13	[399]	CALL 	  1	1	3	;  = table.merge(uv0"self".pending_unloads, list)
			 14	[400]	RET0 	  0		1	; return
		  3	[403]	TGETS	  5	0	58	; slot5 = self.pending_unloads
		  4	[403]	ISF  	   		5	; if not self.pending_unloads
		  5	[403]	JMP  	  6		7	; 	goto 13
		  6	[404]	MOV  	  5		3	; slot5 = unload
		  7	[404]	TGETS	  6	0	58	; slot6 = self.pending_unloads
		  8	[404]	CALL 	  5	1	2	;  = unload(self.pending_unloads)
		  9	[405]	KPRI 	  5		0	; slot5 = nil
		 10	[405]	TSETS	  5	0	58	; self.pending_unloads = slot5
		 11	[406]	GGET 	  5		57	; slot5 = _env["collectgarbage"]
		 12	[406]	CALL 	  5	1	1	;  = collectgarbage()
		 13	[409]	IST  	   		1	; if item
		 14	[409]	JMP  	  5		6	; 	goto 21
		 15	[410]	UGET 	  5		2	; slot5 = uv2"log"
		 16	[410]	TGETS	  5	5	56	; slot5 = uv2"log".debug
		 17	[410]	KSTR 	  6		55	; slot6 = "item nil"
		 18	[410]	CALL 	  5	1	2	;  = uv2"log".debug(slot6)
		 19	[411]	UCLO 	  0		0	; nil uvs >= r0; goto 20
		 20	[411]	RET0 	  0		1	; return
		 21	[414]	TNEW 	  5		0	; slot5 = new table( array: 0, dict: 1)
		 22	[416]	TGETS	  6	1	54	; slot6 = item.item_name
		 23	[416]	ISNES	  6		53	; if item.item_name ~= "game"
		 24	[416]	JMP  	  6		326	; 	goto 351
		 25	[417]	MOV  	  6		1	; slot6 = item
		 26	[420]	GGET 	  7		52	; slot7 = _env["table"]
		 27	[420]	TGETS	  7	7	51	; slot7 = table.insert
		 28	[420]	MOV  	  8		5	; slot8 = list
		 29	[420]	TDUP 	  9		50	; slot9 = copy table#k50
		 30	[420]	UGET 	 10		3	; slot10 = uv3"replace_locale"
		 31	[420]	TGETS	 11	6	49	; slot11 = game.game_gui
		 32	[420]	TGETS	 11	11	48	; slot11 = game.game_gui.required_textures
		 33	[420]	CALL 	 10	2	2	; slot10 = uv3"replace_locale"(game.game_gui.required_textures)
		 34	[420]	TSETS	 10	9	47	; slot9.groups = uv3"replace_locale"
		 35	[420]	TGETS	 10	0	46	; slot10 = self.params
		 36	[420]	TGETS	 10	10	45	; slot10 = self.params.texture_size
		 37	[420]	TSETS	 10	9	45	; slot9.texture_size = self.params.texture_size
		 38	[420]	TGETS	 10	6	49	; slot10 = game.game_gui
		 39	[420]	TGETS	 10	10	44	; slot10 = game.game_gui.ref_res
		 40	[420]	TSETS	 10	9	44	; slot9.ref_res = game.game_gui.ref_res
		 41	[420]	CALL 	  7	1	3	;  = table.insert(list, slot9)
		 42	[423]	TNEW 	  7		0	; slot7 = new table( array: 0, dict: 1)
		 43	[424]	GGET 	  8		52	; slot8 = _env["table"]
		 44	[424]	TGETS	  8	8	43	; slot8 = table.append
		 45	[424]	MOV  	  9		7	; slot9 = groups
		 46	[424]	UGET 	 10		3	; slot10 = uv3"replace_locale"
		 47	[424]	TGETS	 11	6	48	; slot11 = game.required_textures
		 48	[424]	CALL 	 10	0	2	; MULTRES = uv3"replace_locale"(game.required_textures)
		 49	[424]	CALLM	  8	2	1	; slot8 = table.append(groups, ...MULTRES)
		 50	[424]	MOV  	  7		8	; slot7 = table.append
		 51	[425]	GGET 	  8		52	; slot8 = _env["table"]
		 52	[425]	TGETS	  8	8	43	; slot8 = table.append
		 53	[425]	MOV  	  9		7	; slot9 = groups
		 54	[425]	UGET 	 10		3	; slot10 = uv3"replace_locale"
		 55	[425]	TGETS	 11	6	42	; slot11 = game.store
		 56	[425]	TGETS	 11	11	41	; slot11 = game.store.level
		 57	[425]	TGETS	 11	11	48	; slot11 = game.store.level.required_textures
		 58	[425]	CALL 	 10	0	2	; MULTRES = uv3"replace_locale"(game.store.level.required_textures)
		 59	[425]	CALLM	  8	2	1	; slot8 = table.append(groups, ...MULTRES)
		 60	[425]	MOV  	  7		8	; slot7 = table.append
		 61	[426]	TGETS	  8	6	42	; slot8 = game.store
		 62	[426]	TGETS	  8	8	40	; slot8 = game.store.selected_team
		 63	[426]	ISF  	   		8	; if not game.store.selected_team
		 64	[426]	JMP  	  9		15	; 	goto 80
		 65	[427]	GGET 	  8		39	; slot8 = _env["ipairs"]
		 66	[427]	TGETS	  9	6	42	; slot9 = game.store
		 67	[427]	TGETS	  9	9	40	; slot9 = game.store.selected_team
		 68	[427]	CALL 	  8	4	2	; slot8, slot9, slot10 = ipairs(game.store.selected_team)
		 69	[427]	JMP  	 11		7	; 	goto 77
		 70	[428]	GGET 	 13		52	; slot13 = _env["table"]
		 71	[428]	TGETS	 13	13	51	; slot13 = table.insert
		 72	[428]	MOV  	 14		7	; slot14 = groups
		 73	[428]	KSTR 	 15		38	; slot15 = "go_"
		 74	[428]	MOV  	 16		12	; slot16 = hero_name
		 75	[428]	CAT  	 15	15	16	; slot15 = slot15 .. hero_name
		 76	[428]	CALL 	 13	1	3	;  = table.insert(groups, slot15)
		 77	[427]	ITERC	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		 78	[427]	ITERL	 11		-9	; slot10<control> = game.store.level.required_textures; if game.store.level.required_textures != nil goto 70
		 79	[429]	JMP  	  8		12	; 	goto 92
		 80	[430]	TGETS	  8	6	42	; slot8 = game.store
		 81	[430]	TGETS	  8	8	37	; slot8 = game.store.selected_hero
		 82	[430]	ISF  	   		8	; if not game.store.selected_hero
		 83	[430]	JMP  	  9		8	; 	goto 92
		 84	[431]	GGET 	  8		52	; slot8 = _env["table"]
		 85	[431]	TGETS	  8	8	51	; slot8 = table.insert
		 86	[431]	MOV  	  9		7	; slot9 = groups
		 87	[431]	KSTR 	 10		38	; slot10 = "go_"
		 88	[431]	TGETS	 11	6	42	; slot11 = game.store
		 89	[431]	TGETS	 11	11	37	; slot11 = game.store.selected_hero
		 90	[431]	CAT  	 10	10	11	; slot10 = slot10 .. game.store.selected_hero
		 91	[431]	CALL 	  8	1	3	;  = table.insert(groups, slot10)
		 92	[434]	UGET 	  8		4	; slot8 = uv4"storage"
		 93	[434]	MOV  	  9		8	; slot9 = uv4"storage"
		 94	[434]	TGETS	  8	8	36	; slot8 = uv4"storage".load_slot
		 95	[434]	CALL 	  8	2	2	; slot8 = uv4"storage".load_slot(uv4"storage")
		 96	[435]	TGETS	  9	8	35	; slot9 = slot.towers
		 97	[435]	ISF  	   		9	; if not slot.towers
		 98	[435]	JMP  	 10		64	; 	goto 163
		 99	[435]	TGETS	  9	8	35	; slot9 = slot.towers
		100	[435]	TGETS	  9	9	34	; slot9 = slot.towers.selected
		101	[435]	ISF  	   		9	; if not slot.towers.selected
		102	[435]	JMP  	 10		60	; 	goto 163
		103	[436]	TGETS	  9	6	42	; slot9 = game.store
		104	[436]	TGETS	  9	9	41	; slot9 = game.store.level
		105	[436]	TGETS	  9	9	33	; slot9 = game.store.level.available_towers
		106	[436]	ISF  	   		9	; if not game.store.level.available_towers
		107	[436]	JMP  	 10		22	; 	goto 130
		108	[438]	GGET 	  9		39	; slot9 = _env["ipairs"]
		109	[438]	TGETS	 10	6	42	; slot10 = game.store
		110	[438]	TGETS	 10	10	41	; slot10 = game.store.level
		111	[438]	TGETS	 10	10	33	; slot10 = game.store.level.available_towers
		112	[438]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(game.store.level.available_towers)
		113	[438]	JMP  	 12		13	; 	goto 127
		114	[439]	MOV  	 15		13	; slot15 = tower
		115	[439]	TGETS	 14	13	32	; slot14 = tower.gsub
		116	[439]	KSTR 	 16		31	; slot16 = "tower_build_"
		117	[439]	KSTR 	 17		30	; slot17 = ""
		118	[439]	CALL 	 14	2	4	; slot14 = tower.gsub(tower, slot16, slot17)
		119	[440]	KSTR 	 15		29	; slot15 = "go_towers_"
		120	[440]	MOV  	 16		14	; slot16 = tower_name
		121	[440]	CAT  	 15	15	16	; slot15 = slot15 .. tower_name
		122	[441]	GGET 	 16		52	; slot16 = _env["table"]
		123	[441]	TGETS	 16	16	51	; slot16 = table.insert
		124	[441]	MOV  	 17		7	; slot17 = groups
		125	[441]	MOV  	 18		15	; slot18 = tower_texture
		126	[441]	CALL 	 16	1	3	;  = table.insert(groups, tower_texture)
		127	[438]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		128	[438]	ITERL	 12		-15	; slot11<control> = slot12; if slot12 != nil goto 114
		129	[442]	JMP  	  9		33	; 	goto 163
		130	[444]	TGETS	  9	6	42	; slot9 = game.store
		131	[444]	TGETS	  9	9	28	; slot9 = game.store.selected_towers
		132	[444]	ISF  	   		9	; if not game.store.selected_towers
		133	[444]	JMP  	 10		15	; 	goto 149
		134	[446]	GGET 	  9		39	; slot9 = _env["ipairs"]
		135	[446]	TGETS	 10	6	42	; slot10 = game.store
		136	[446]	TGETS	 10	10	28	; slot10 = game.store.selected_towers
		137	[446]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(game.store.selected_towers)
		138	[446]	JMP  	 12		7	; 	goto 146
		139	[447]	GGET 	 14		52	; slot14 = _env["table"]
		140	[447]	TGETS	 14	14	51	; slot14 = table.insert
		141	[447]	MOV  	 15		7	; slot15 = groups
		142	[447]	KSTR 	 16		29	; slot16 = "go_towers_"
		143	[447]	MOV  	 17		13	; slot17 = tower
		144	[447]	CAT  	 16	16	17	; slot16 = slot16 .. tower
		145	[447]	CALL 	 14	1	3	;  = table.insert(groups, slot16)
		146	[446]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		147	[446]	ITERL	 12		-9	; slot11<control> = slot12; if slot12 != nil goto 139
		148	[448]	JMP  	  9		14	; 	goto 163
		149	[450]	GGET 	  9		39	; slot9 = _env["ipairs"]
		150	[450]	TGETS	 10	8	35	; slot10 = slot.towers
		151	[450]	TGETS	 10	10	34	; slot10 = slot.towers.selected
		152	[450]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(slot.towers.selected)
		153	[450]	JMP  	 12		7	; 	goto 161
		154	[451]	GGET 	 14		52	; slot14 = _env["table"]
		155	[451]	TGETS	 14	14	51	; slot14 = table.insert
		156	[451]	MOV  	 15		7	; slot15 = groups
		157	[451]	KSTR 	 16		29	; slot16 = "go_towers_"
		158	[451]	MOV  	 17		13	; slot17 = tower
		159	[451]	CAT  	 16	16	17	; slot16 = slot16 .. tower
		160	[451]	CALL 	 14	1	3	;  = table.insert(groups, slot16)
		161	[450]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		162	[450]	ITERL	 12		-9	; slot11<control> = slot12; if slot12 != nil goto 154
		163	[457]	TGETS	  9	8	27	; slot9 = slot.items
		164	[457]	ISF  	   		9	; if not slot.items
		165	[457]	JMP  	 10		18	; 	goto 184
		166	[457]	TGETS	  9	8	27	; slot9 = slot.items
		167	[457]	TGETS	  9	9	34	; slot9 = slot.items.selected
		168	[457]	ISF  	   		9	; if not slot.items.selected
		169	[457]	JMP  	 10		14	; 	goto 184
		170	[458]	GGET 	  9		39	; slot9 = _env["ipairs"]
		171	[458]	TGETS	 10	8	27	; slot10 = slot.items
		172	[458]	TGETS	 10	10	34	; slot10 = slot.items.selected
		173	[458]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(slot.items.selected)
		174	[458]	JMP  	 12		7	; 	goto 182
		175	[459]	GGET 	 14		52	; slot14 = _env["table"]
		176	[459]	TGETS	 14	14	51	; slot14 = table.insert
		177	[459]	MOV  	 15		7	; slot15 = groups
		178	[459]	KSTR 	 16		26	; slot16 = "go_items_"
		179	[459]	MOV  	 17		13	; slot17 = item
		180	[459]	CAT  	 16	16	17	; slot16 = slot16 .. item
		181	[459]	CALL 	 14	1	3	;  = table.insert(groups, slot16)
		182	[458]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		183	[458]	ITERL	 12		-9	; slot11<control> = slot12; if slot12 != nil goto 175
		184	[463]	TGETS	  9	8	25	; slot9 = slot.powers
		185	[463]	ISF  	   		9	; if not slot.powers
		186	[463]	JMP  	 10		37	; 	goto 224
		187	[463]	TGETS	  9	8	25	; slot9 = slot.powers
		188	[463]	TGETS	  9	9	34	; slot9 = slot.powers.selected
		189	[463]	ISF  	   		9	; if not slot.powers.selected
		190	[463]	JMP  	 10		33	; 	goto 224
		191	[464]	TGETS	  9	6	42	; slot9 = game.store
		192	[464]	TGETS	  9	9	24	; slot9 = game.store.selected_powers
		193	[464]	ISF  	   		9	; if not game.store.selected_powers
		194	[464]	JMP  	 10		15	; 	goto 210
		195	[465]	GGET 	  9		39	; slot9 = _env["ipairs"]
		196	[465]	TGETS	 10	6	42	; slot10 = game.store
		197	[465]	TGETS	 10	10	24	; slot10 = game.store.selected_powers
		198	[465]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(game.store.selected_powers)
		199	[465]	JMP  	 12		7	; 	goto 207
		200	[466]	GGET 	 14		52	; slot14 = _env["table"]
		201	[466]	TGETS	 14	14	51	; slot14 = table.insert
		202	[466]	MOV  	 15		7	; slot15 = groups
		203	[466]	KSTR 	 16		23	; slot16 = "go_power_"
		204	[466]	MOV  	 17		13	; slot17 = pow
		205	[466]	CAT  	 16	16	17	; slot16 = slot16 .. pow
		206	[466]	CALL 	 14	1	3	;  = table.insert(groups, slot16)
		207	[465]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		208	[465]	ITERL	 12		-9	; slot11<control> = slot12; if slot12 != nil goto 200
		209	[467]	JMP  	  9		14	; 	goto 224
		210	[469]	GGET 	  9		39	; slot9 = _env["ipairs"]
		211	[469]	TGETS	 10	8	25	; slot10 = slot.powers
		212	[469]	TGETS	 10	10	34	; slot10 = slot.powers.selected
		213	[469]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(slot.powers.selected)
		214	[469]	JMP  	 12		7	; 	goto 222
		215	[470]	GGET 	 14		52	; slot14 = _env["table"]
		216	[470]	TGETS	 14	14	51	; slot14 = table.insert
		217	[470]	MOV  	 15		7	; slot15 = groups
		218	[470]	KSTR 	 16		23	; slot16 = "go_power_"
		219	[470]	MOV  	 17		13	; slot17 = pow
		220	[470]	CAT  	 16	16	17	; slot16 = slot16 .. pow
		221	[470]	CALL 	 14	1	3	;  = table.insert(groups, slot16)
		222	[469]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		223	[469]	ITERL	 12		-9	; slot11<control> = slot12; if slot12 != nil goto 215
		224	[475]	GGET 	  9		52	; slot9 = _env["table"]
		225	[475]	TGETS	  9	9	51	; slot9 = table.insert
		226	[475]	MOV  	 10		5	; slot10 = list
		227	[475]	TDUP 	 11		22	; slot11 = copy table#k22
		228	[475]	TSETS	  7	11	47	; slot11.groups = groups
		229	[475]	TGETS	 12	0	46	; slot12 = self.params
		230	[475]	TGETS	 12	12	45	; slot12 = self.params.texture_size
		231	[475]	TSETS	 12	11	45	; slot11.texture_size = self.params.texture_size
		232	[475]	TGETS	 12	6	44	; slot12 = game.ref_res
		233	[475]	TSETS	 12	11	44	; slot11.ref_res = game.ref_res
		234	[475]	CALL 	  9	1	3	;  = table.insert(list, slot11)
		235	[478]	GGET 	  9		52	; slot9 = _env["table"]
		236	[478]	TGETS	  9	9	51	; slot9 = table.insert
		237	[478]	MOV  	 10		5	; slot10 = list
		238	[478]	TDUP 	 11		21	; slot11 = copy table#k21
		239	[478]	TGETS	 12	6	42	; slot12 = game.store
		240	[478]	TGETS	 12	12	20	; slot12 = game.store.screen_scale
		241	[478]	TSETS	 12	11	19	; slot11.scale = game.store.screen_scale
		242	[478]	CALL 	  9	1	3	;  = table.insert(list, slot11)
		243	[481]	TGETS	  9	1	18	; slot9 = item.required_sounds
		244	[481]	ISF  	   		9	; if not item.required_sounds
		245	[481]	JMP  	 10		12	; 	goto 258
		246	[482]	GGET 	  9		17	; slot9 = _env["pairs"]
		247	[482]	TGETS	 10	1	18	; slot10 = item.required_sounds
		248	[482]	CALL 	  9	4	2	; slot9, slot10, slot11 = pairs(item.required_sounds)
		249	[482]	ISNEXT	 12		6	; Verify ITERN at 256; goto 256
		250	[483]	GGET 	 14		52	; slot14 = _env["table"]
		251	[483]	TGETS	 14	14	51	; slot14 = table.insert
		252	[483]	MOV  	 15		5	; slot15 = list
		253	[483]	TDUP 	 16		16	; slot16 = copy table#k16
		254	[483]	TSETS	 13	16	15	; slot16.group = group
		255	[483]	CALL 	 14	1	3	;  = table.insert(list, slot16)
		256	[482]	ITERN	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		257	[482]	ITERL	 12		-8	; slot11<control> = game.store.screen_scale; if game.store.screen_scale != nil goto 250
		258	[486]	TGETS	  9	6	42	; slot9 = game.store
		259	[486]	TGETS	  9	9	41	; slot9 = game.store.level
		260	[486]	TGETS	  9	9	18	; slot9 = game.store.level.required_sounds
		261	[486]	ISF  	   		9	; if not game.store.level.required_sounds
		262	[486]	JMP  	 10		14	; 	goto 277
		263	[487]	GGET 	  9		17	; slot9 = _env["pairs"]
		264	[487]	TGETS	 10	6	42	; slot10 = game.store
		265	[487]	TGETS	 10	10	41	; slot10 = game.store.level
		266	[487]	TGETS	 10	10	18	; slot10 = game.store.level.required_sounds
		267	[487]	CALL 	  9	4	2	; slot9, slot10, slot11 = pairs(game.store.level.required_sounds)
		268	[487]	ISNEXT	 12		6	; Verify ITERN at 275; goto 275
		269	[488]	GGET 	 14		52	; slot14 = _env["table"]
		270	[488]	TGETS	 14	14	51	; slot14 = table.insert
		271	[488]	MOV  	 15		5	; slot15 = list
		272	[488]	TDUP 	 16		14	; slot16 = copy table#k14
		273	[488]	TSETS	 13	16	15	; slot16.group = group
		274	[488]	CALL 	 14	1	3	;  = table.insert(list, slot16)
		275	[487]	ITERN	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		276	[487]	ITERL	 12		-8	; slot11<control> = game.store.screen_scale; if game.store.screen_scale != nil goto 269
		277	[493]	TGETS	  9	6	42	; slot9 = game.store
		278	[493]	TGETS	  9	9	40	; slot9 = game.store.selected_team
		279	[493]	ISF  	   		9	; if not game.store.selected_team
		280	[493]	JMP  	 10		14	; 	goto 295
		281	[494]	GGET 	  9		39	; slot9 = _env["ipairs"]
		282	[494]	TGETS	 10	6	42	; slot10 = game.store
		283	[494]	TGETS	 10	10	40	; slot10 = game.store.selected_team
		284	[494]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(game.store.selected_team)
		285	[494]	JMP  	 12		6	; 	goto 292
		286	[495]	GGET 	 14		52	; slot14 = _env["table"]
		287	[495]	TGETS	 14	14	51	; slot14 = table.insert
		288	[495]	MOV  	 15		5	; slot15 = list
		289	[495]	TDUP 	 16		13	; slot16 = copy table#k13
		290	[495]	TSETS	 13	16	15	; slot16.group = hero_name
		291	[495]	CALL 	 14	1	3	;  = table.insert(list, slot16)
		292	[494]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		293	[494]	ITERL	 12		-8	; slot11<control> = game.store.screen_scale; if game.store.screen_scale != nil goto 286
		294	[496]	JMP  	  9		12	; 	goto 307
		295	[497]	TGETS	  9	6	42	; slot9 = game.store
		296	[497]	TGETS	  9	9	37	; slot9 = game.store.selected_hero
		297	[497]	ISF  	   		9	; if not game.store.selected_hero
		298	[497]	JMP  	 10		8	; 	goto 307
		299	[498]	GGET 	  9		52	; slot9 = _env["table"]
		300	[498]	TGETS	  9	9	51	; slot9 = table.insert
		301	[498]	MOV  	 10		5	; slot10 = list
		302	[498]	TDUP 	 11		12	; slot11 = copy table#k12
		303	[498]	TGETS	 12	6	42	; slot12 = game.store
		304	[498]	TGETS	 12	12	37	; slot12 = game.store.selected_hero
		305	[498]	TSETS	 12	11	15	; slot11.group = game.store.selected_hero
		306	[498]	CALL 	  9	1	3	;  = table.insert(list, slot11)
		307	[501]	TGETS	  9	8	27	; slot9 = slot.items
		308	[501]	ISF  	   		9	; if not slot.items
		309	[501]	JMP  	 10		20	; 	goto 330
		310	[501]	TGETS	  9	8	27	; slot9 = slot.items
		311	[501]	TGETS	  9	9	34	; slot9 = slot.items.selected
		312	[501]	ISF  	   		9	; if not slot.items.selected
		313	[501]	JMP  	 10		16	; 	goto 330
		314	[502]	GGET 	  9		39	; slot9 = _env["ipairs"]
		315	[502]	TGETS	 10	8	27	; slot10 = slot.items
		316	[502]	TGETS	 10	10	34	; slot10 = slot.items.selected
		317	[502]	CALL 	  9	4	2	; slot9, slot10, slot11 = ipairs(slot.items.selected)
		318	[502]	JMP  	 12		9	; 	goto 328
		319	[503]	GGET 	 14		52	; slot14 = _env["table"]
		320	[503]	TGETS	 14	14	51	; slot14 = table.insert
		321	[503]	MOV  	 15		5	; slot15 = list
		322	[503]	TDUP 	 16		11	; slot16 = copy table#k11
		323	[503]	KSTR 	 17		10	; slot17 = "item_"
		324	[503]	MOV  	 18		13	; slot18 = item
		325	[503]	CAT  	 17	17	18	; slot17 = slot17 .. item
		326	[503]	TSETS	 17	16	15	; slot16.group = slot17
		327	[503]	CALL 	 14	1	3	;  = table.insert(list, slot16)
		328	[502]	ITERC	 12	3	3	; slot12, slot13, slot14 = slot9<generator>, slot10<state>, slot11<control>; slot12, slot13 = slot9<generator>(slot10<state>, slot11<control>)
		329	[502]	ITERL	 12		-11	; slot11<control> = game.store.selected_hero; if game.store.selected_hero != nil goto 319
		330	[541]	ISF  	   		2	; if not postponed
		331	[541]	JMP  	  9		4	; 	goto 336
		332	[542]	MOV  	  9		4	; slot9 = postpone
		333	[542]	MOV  	 10		5	; slot10 = list
		334	[542]	CALL 	  9	1	2	;  = postpone(list)
		335	[542]	JMP  	  9		3	; 	goto 339
		336	[544]	MOV  	  9		3	; slot9 = unload
		337	[544]	MOV  	 10		5	; slot10 = list
		338	[544]	CALL 	  9	1	2	;  = unload(list)
		339	[547]	MOV  	 10		6	; slot10 = game
		340	[547]	TGETS	  9	6	9	; slot9 = game.destroy
		341	[547]	CALL 	  9	1	2	;  = game.destroy(game)
		342	[548]	KPRI 	  9		0	; slot9 = nil
		343	[548]	TSETS	  9	6	42	; game.store = slot9
		344	[549]	GGET 	  9		8	; slot9 = _env["package"]
		345	[549]	TGETS	  9	9	7	; slot9 = package.loaded
		346	[549]	KPRI 	 10		0	; slot10 = nil
		347	[549]	TSETS	 10	9	6	; package.loaded.exoskeleton = slot10
		348	[550]	GGET 	  9		57	; slot9 = _env["collectgarbage"]
		349	[550]	CALL 	  9	1	1	;  = collectgarbage()
		350	[550]	JMP  	  6		59	; 	goto 410
		351	[552]	TGETS	  6	1	5	; slot6 = item.keep_loaded
		352	[552]	IST  	   		6	; if item.keep_loaded
		353	[552]	JMP  	  6		56	; 	goto 410
		354	[553]	TGETS	  6	1	48	; slot6 = item.required_textures
		355	[554]	ISF  	   		6	; if not textures
		356	[554]	JMP  	  7		21	; 	goto 378
		357	[555]	MOV  	  8		0	; slot8 = self
		358	[555]	TGETS	  7	0	4	; slot7 = self.get_texture_scale
		359	[555]	TGETS	  9	1	54	; slot9 = item.item_name
		360	[555]	TGETS	 10	1	44	; slot10 = item.ref_res
		361	[555]	CALL 	  7	2	4	; slot7 = self.get_texture_scale(self, item.item_name, item.ref_res)
		362	[556]	GGET 	  8		17	; slot8 = _env["pairs"]
		363	[556]	UGET 	  9		3	; slot9 = uv3"replace_locale"
		364	[556]	MOV  	 10		6	; slot10 = textures
		365	[556]	TGETS	 11	1	3	; slot11 = item.locale_at_requirement
		366	[556]	CALL 	  9	0	3	; MULTRES = uv3"replace_locale"(textures, item.locale_at_requirement)
		367	[556]	CALLM	  8	4	0	; slot8, slot9, slot10 = pairs(, ...MULTRES)
		368	[556]	ISNEXT	 11		7	; Verify ITERN at 376; goto 376
		369	[557]	GGET 	 13		52	; slot13 = _env["table"]
		370	[557]	TGETS	 13	13	51	; slot13 = table.insert
		371	[557]	MOV  	 14		5	; slot14 = list
		372	[557]	TDUP 	 15		2	; slot15 = copy table#k2
		373	[557]	TSETS	 12	15	1	; slot15.atlas_name = group
		374	[557]	TSETS	  7	15	19	; slot15.scale = scale
		375	[557]	CALL 	 13	1	3	;  = table.insert(list, slot15)
		376	[556]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		377	[556]	ITERL	 11		-9	; slot10<control> = item.locale_at_requirement; if item.locale_at_requirement != nil goto 369
		378	[560]	TGETS	  7	1	18	; slot7 = item.required_sounds
		379	[560]	ISF  	   		7	; if not item.required_sounds
		380	[560]	JMP  	  8		12	; 	goto 393
		381	[561]	GGET 	  7		17	; slot7 = _env["pairs"]
		382	[561]	TGETS	  8	1	18	; slot8 = item.required_sounds
		383	[561]	CALL 	  7	4	2	; slot7, slot8, slot9 = pairs(item.required_sounds)
		384	[561]	ISNEXT	 10		6	; Verify ITERN at 391; goto 391
		385	[562]	GGET 	 12		52	; slot12 = _env["table"]
		386	[562]	TGETS	 12	12	51	; slot12 = table.insert
		387	[562]	MOV  	 13		5	; slot13 = list
		388	[562]	TDUP 	 14		0	; slot14 = copy table#k0
		389	[562]	TSETS	 11	14	15	; slot14.group = group
		390	[562]	CALL 	 12	1	3	;  = table.insert(list, slot14)
		391	[561]	ITERN	 10	3	3	; slot10, slot11, slot12 = slot7<generator>, slot8<state>, slot9<control>; slot10, slot11 = slot7<generator>(slot8<state>, slot9<control>)
		392	[561]	ITERL	 10		-8	; slot9<control> = textures; if textures != nil goto 385
		393	[566]	ISF  	   		2	; if not postponed
		394	[566]	JMP  	  7		4	; 	goto 399
		395	[567]	MOV  	  7		4	; slot7 = postpone
		396	[567]	MOV  	  8		5	; slot8 = list
		397	[567]	CALL 	  7	1	2	;  = postpone(list)
		398	[567]	JMP  	  7		3	; 	goto 402
		399	[569]	MOV  	  7		3	; slot7 = unload
		400	[569]	MOV  	  8		5	; slot8 = list
		401	[569]	CALL 	  7	1	2	;  = unload(list)
		402	[572]	TGETS	  7	1	9	; slot7 = item.destroy
		403	[572]	ISF  	   		7	; if not item.destroy
		404	[572]	JMP  	  8		3	; 	goto 408
		405	[573]	MOV  	  8		1	; slot8 = item
		406	[573]	TGETS	  7	1	9	; slot7 = item.destroy
		407	[573]	CALL 	  7	1	2	;  = item.destroy(item)
		408	[575]	GGET 	  7		57	; slot7 = _env["collectgarbage"]
		409	[575]	CALL 	  7	1	1	;  = collectgarbage()
		410	[577]	UCLO 	  0		0	; nil uvs >= r0; goto 411
		411	[577]	RET0 	  0		1	; return
	 96	[381]	TSETS	 23	22	62	; director.unload_item = slot23
	 97	[579]	GGET 	 22		99	; slot22 = _env["director"]
	 98	[819]	FNEW 	 23		59	; @./all/director.lua:579-819: 3 args, 6 upvalues, 26 slots
		
		;;;; constant tables ;;;;
		ktable#53 = [
			#1: loading_common,
			]
		
		
		ktable#84 = [
			#1: _debug_textures,
			]
		
		
		;;;; upvalue names ;;;;
		  0:	i18n
		  1:	log
		  2:	I
		  3:	replace_locale
		  4:	LU
		  5:	storage
		;;;; variable info ;;;;
		  0-708:	self
		  0-708:	name
		  0-708:	force_reload
		  1-708:	_require
		  3-708:	props
		  53-708:	show_loading
		  64-122:	loading
		  65-122:	level_idx
		  133-167:	item
		  172-206:	args
		  173-206:	comic_idx
		  176-206:	item
		  189-206:	comic_data_file
		  213-700:	game_gui
		  216-700:	game
		  221-700:	args
		  355-700:	slot
		  356-700:	heroes
		  405-413:	<generator>
		  405-413:	<state>
		  405-413:	<control>
		  406-411:	_
		  406-411:	hero
		  421-429:	<generator>
		  421-429:	<state>
		  421-429:	<control>
		  422-427:	k
		  422-427:	v
		  432-454:	<generator>
		  432-454:	<state>
		  432-454:	<control>
		  433-452:	_
		  433-452:	hero
		  438-452:	hero_textures
		  455-700:	towers
		  472-485:	<generator>
		  472-485:	<state>
		  472-485:	<control>
		  473-483:	_
		  473-483:	tower
		  478-483:	tower_name
		  490-498:	<generator>
		  490-498:	<state>
		  490-498:	<control>
		  491-496:	_
		  491-496:	tower
		  507-515:	<generator>
		  507-515:	<state>
		  507-515:	<control>
		  508-513:	_
		  508-513:	tower
		  518-543:	<generator>
		  518-543:	<state>
		  518-543:	<control>
		  519-541:	_
		  519-541:	tower
		  524-541:	tower_texture
		  554-579:	<generator>
		  554-579:	<state>
		  554-579:	<control>
		  555-577:	_
		  555-577:	item
		  560-577:	item_texture
		  580-700:	powers
		  591-599:	<generator>
		  591-599:	<state>
		  591-599:	<control>
		  592-597:	_
		  592-597:	power
		  608-616:	<generator>
		  608-616:	<state>
		  608-616:	<control>
		  609-614:	_
		  609-614:	power
		  619-644:	<generator>
		  619-644:	<state>
		  619-644:	<control>
		  620-642:	_
		  620-642:	power
		  625-642:	power_texture
		  660-698:	comic_idx
		  663-698:	item
		  679-698:	comic_data_file
		;;;; instructions ;;;;
		  1	[592]	FNEW 	  3		101	; @./all/director.lua:580-592: 2 args, 2 upvalues, 9 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			  0:	force_reload
			  1:	i18n
			;;;; variable info ;;;;
			  0-35:	name
			  0-35:	force
			  17-24:	<generator>
			  17-24:	<state>
			  17-24:	<control>
			  18-22:	_
			  18-22:	n
			  31-35:	r
			;;;; instructions ;;;;
			  1	[581]	UGET 	  2		0	; slot2 = uv0"force_reload"
			  2	[581]	IST  	   		2	; if uv0"force_reload"
			  3	[581]	JMP  	  3		2	; 	goto 6
			  4	[581]	ISF  	   		1	; if not force
			  5	[581]	JMP  	  2		23	; 	goto 29
			  6	[582]	GGET 	  2		6	; slot2 = _env["package"]
			  7	[582]	TGETS	  2	2	5	; slot2 = package.loaded
			  8	[582]	TGETV	  2	2	0	; slot2 = package.loaded[name]
			  9	[582]	TGETS	  2	2	4	; slot2 = slot2.reload_list
			 10	[582]	ISF  	   		2	; if not <unknown table>.reload_list
			 11	[582]	JMP  	  3		13	; 	goto 25
			 12	[583]	GGET 	  2		3	; slot2 = _env["pairs"]
			 13	[583]	GGET 	  3		6	; slot3 = _env["package"]
			 14	[583]	TGETS	  3	3	5	; slot3 = package.loaded
			 15	[583]	TGETV	  3	3	0	; slot3 = package.loaded[name]
			 16	[583]	TGETS	  3	3	4	; slot3 = slot3.reload_list
			 17	[583]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(<unknown table>.reload_list)
			 18	[583]	ISNEXT	  5		4	; Verify ITERN at 23; goto 23
			 19	[584]	GGET 	  7		6	; slot7 = _env["package"]
			 20	[584]	TGETS	  7	7	5	; slot7 = package.loaded
			 21	[584]	KPRI 	  8		0	; slot8 = nil
			 22	[584]	TSETV	  8	7	6	; package.loaded[n] = slot8
			 23	[583]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
			 24	[583]	ITERL	  5		-6	; slot4<control> = slot5; if slot5 != nil goto 19
			 25	[587]	GGET 	  2		6	; slot2 = _env["package"]
			 26	[587]	TGETS	  2	2	5	; slot2 = package.loaded
			 27	[587]	KPRI 	  3		0	; slot3 = nil
			 28	[587]	TSETV	  3	2	0	; package.loaded[name] = slot3
			 29	[589]	GGET 	  2		2	; slot2 = _env["require"]
			 30	[589]	MOV  	  3		0	; slot3 = name
			 31	[589]	CALL 	  2	2	2	; slot2 = require(name)
			 32	[590]	UGET 	  3		1	; slot3 = uv1"i18n"
			 33	[590]	TGETS	  3	3	0	; slot3 = uv1"i18n".current_locale
			 34	[590]	TSETS	  3	2	1	; r.locale_at_requirement = uv1"i18n".current_locale
			 35	[591]	RET1 	  2		2	; return r
		  2	[594]	TGETS	  4	0	100	; slot4 = self.item_props
		  3	[594]	TGETV	  4	4	1	; slot4 = self.item_props[name]
		  4	[595]	TSETS	  1	0	99	; self.load_ctx = name
		  5	[596]	ISF  	   		4	; if not props
		  6	[596]	JMP  	  5		22	; 	goto 29
		  7	[596]	TGETS	  5	4	98	; slot5 = props.type
		  8	[596]	ISNES	  5		97	; if props.type ~= "game"
		  9	[596]	JMP  	  5		19	; 	goto 29
		 10	[596]	TGETS	  5	0	96	; slot5 = self.next_item_args
		 11	[596]	ISF  	   		5	; if not self.next_item_args
		 12	[596]	JMP  	  6		16	; 	goto 29
		 13	[596]	TGETS	  5	0	96	; slot5 = self.next_item_args
		 14	[596]	TGETS	  5	5	95	; slot5 = self.next_item_args.level_idx
		 15	[596]	ISF  	   		5	; if not self.next_item_args.level_idx
		 16	[596]	JMP  	  6		12	; 	goto 29
		 17	[597]	GGET 	  5		94	; slot5 = _env["string"]
		 18	[597]	TGETS	  5	5	93	; slot5 = string.format
		 19	[597]	KSTR 	  6		92	; slot6 = "game/level%02i/%i"
		 20	[597]	TGETS	  7	0	96	; slot7 = self.next_item_args
		 21	[597]	TGETS	  7	7	95	; slot7 = self.next_item_args.level_idx
		 22	[597]	TGETS	  8	0	96	; slot8 = self.next_item_args
		 23	[597]	TGETS	  8	8	91	; slot8 = self.next_item_args.level_mode
		 24	[597]	IST  	   		8	; if self.next_item_args.level_mode
		 25	[597]	JMP  	  9		1	; 	goto 27
		 26	[597]	KSHORT	  8		0	; slot8 = 0
		 27	[597]	CALL 	  5	2	4	; slot5 = string.format(slot6, self.next_item_args.level_idx, slot8)
		 28	[597]	TSETS	  5	0	99	; self.load_ctx = string.format
		 29	[599]	UGET 	  5		1	; slot5 = uv1"log"
		 30	[599]	TGETS	  5	5	90	; slot5 = uv1"log".start_time
		 31	[599]	TGETS	  6	0	99	; slot6 = self.load_ctx
		 32	[599]	CALL 	  5	1	2	;  = uv1"log".start_time(self.load_ctx)
		 33	[602]	MOV  	  6		0	; slot6 = self
		 34	[602]	TGETS	  5	0	89	; slot5 = self.reset_screen_params
		 35	[602]	ISFC 	  7		4	; slot7 = props; if not props
		 36	[602]	JMP  	  7		1	; 	goto 38
		 37	[602]	TGETS	  7	4	88	; slot7 = props.scissor
		 38	[602]	CALL 	  5	1	3	;  = self.reset_screen_params(self, props.scissor)
		 39	[605]	UGET 	  5		2	; slot5 = uv2"I"
		 40	[605]	TNEW 	  6		0	; slot6 = new table( array: 0, dict: 1)
		 41	[605]	TSETS	  6	5	87	; uv2"I".last_preloaded_group_names = slot6
		 42	[607]	GGET 	  5		86	; slot5 = _env["DBG_REPLACE_MISSING_TEXTURES"]
		 43	[607]	ISF  	   		5	; if not DBG_REPLACE_MISSING_TEXTURES
		 44	[607]	JMP  	  6		8	; 	goto 53
		 45	[608]	MOV  	  6		0	; slot6 = self
		 46	[608]	TGETS	  5	0	85	; slot5 = self.load_texture_groups
		 47	[608]	TDUP 	  7		84	; slot7 = copy table#k84
		 48	[608]	TGETS	  8	0	83	; slot8 = self.params
		 49	[608]	TGETS	  8	8	82	; slot8 = self.params.texture_size
		 50	[608]	KSHORT	  9		480	; slot9 = 480
		 51	[608]	KPRI 	 10		1	; slot10 = false
		 52	[608]	CALL 	  5	1	6	;  = self.load_texture_groups(self, slot7, self.params.texture_size, slot9, slot10)
		 53	[612]	TGETS	  5	4	81	; slot5 = props.show_loading
		 54	[613]	TGETS	  6	0	80	; slot6 = self.next_item_prevent_loading
		 55	[613]	ISF  	   		6	; if not self.next_item_prevent_loading
		 56	[613]	JMP  	  7		3	; 	goto 60
		 57	[614]	KPRI 	  5		1	; slot5 = false
		 58	[615]	KPRI 	  6		0	; slot6 = nil
		 59	[615]	TSETS	  6	0	80	; self.next_item_prevent_loading = slot6
		 60	[617]	ISF  	   		5	; if not show_loading
		 61	[617]	JMP  	  6		61	; 	goto 123
		 62	[618]	MOV  	  6		3	; slot6 = _require
		 63	[618]	KSTR 	  7		79	; slot7 = "screen_loading"
		 64	[618]	CALL 	  6	2	2	; slot6 = _require(slot7)
		 65	[619]	KPRI 	  7		0	; slot7 = nil
		 66	[620]	GGET 	  8		97	; slot8 = _env["game"]
		 67	[620]	ISF  	   		8	; if not game
		 68	[620]	JMP  	  9		13	; 	goto 82
		 69	[620]	GGET 	  8		97	; slot8 = _env["game"]
		 70	[620]	TGETS	  8	8	78	; slot8 = game.store
		 71	[620]	ISF  	   		8	; if not game.store
		 72	[620]	JMP  	  9		9	; 	goto 82
		 73	[620]	GGET 	  8		97	; slot8 = _env["game"]
		 74	[620]	TGETS	  8	8	78	; slot8 = game.store
		 75	[620]	TGETS	  8	8	95	; slot8 = game.store.level_idx
		 76	[620]	ISF  	   		8	; if not game.store.level_idx
		 77	[620]	JMP  	  9		4	; 	goto 82
		 78	[621]	GGET 	  8		97	; slot8 = _env["game"]
		 79	[621]	TGETS	  8	8	78	; slot8 = game.store
		 80	[621]	TGETS	  7	8	95	; slot7 = game.store.level_idx
		 81	[621]	JMP  	  8		5	; 	goto 87
		 82	[622]	TGETS	  8	0	96	; slot8 = self.next_item_args
		 83	[622]	ISF  	   		8	; if not self.next_item_args
		 84	[622]	JMP  	  9		2	; 	goto 87
		 85	[623]	TGETS	  8	0	96	; slot8 = self.next_item_args
		 86	[623]	TGETS	  7	8	95	; slot7 = self.next_item_args.level_idx
		 87	[625]	TGETS	  8	6	77	; slot8 = loading.update_required_textures
		 88	[625]	ISF  	   		8	; if not loading.update_required_textures
		 89	[625]	JMP  	  9		5	; 	goto 95
		 90	[626]	MOV  	  9		6	; slot9 = loading
		 91	[626]	TGETS	  8	6	77	; slot8 = loading.update_required_textures
		 92	[626]	MOV  	 10		1	; slot10 = name
		 93	[626]	MOV  	 11		7	; slot11 = level_idx
		 94	[626]	CALL 	  8	1	4	;  = loading.update_required_textures(loading, name, level_idx)
		 95	[628]	MOV  	  9		0	; slot9 = self
		 96	[628]	TGETS	  8	0	85	; slot8 = self.load_texture_groups
		 97	[628]	TGETS	 10	6	76	; slot10 = loading.required_textures
		 98	[629]	TGETS	 11	0	83	; slot11 = self.params
		 99	[629]	TGETS	 11	11	82	; slot11 = self.params.texture_size
		100	[629]	TGETS	 12	6	75	; slot12 = loading.ref_res
		101	[629]	KPRI 	 13		1	; slot13 = false
		102	[628]	CALL 	  8	1	6	;  = self.load_texture_groups(self, loading.required_textures, self.params.texture_size, loading.ref_res, slot13)
		103	[630]	TGETS	  8	6	74	; slot8 = loading.required_sounds
		104	[630]	ISF  	   		8	; if not loading.required_sounds
		105	[630]	JMP  	  9		4	; 	goto 110
		106	[631]	MOV  	  9		0	; slot9 = self
		107	[631]	TGETS	  8	0	73	; slot8 = self.load_sound_groups
		108	[631]	TGETS	 10	6	74	; slot10 = loading.required_sounds
		109	[631]	CALL 	  8	1	3	;  = self.load_sound_groups(self, loading.required_sounds)
		110	[633]	MOV  	  9		6	; slot9 = loading
		111	[633]	TGETS	  8	6	72	; slot8 = loading.init
		112	[633]	TGETS	 10	0	83	; slot10 = self.params
		113	[633]	TGETS	 10	10	71	; slot10 = self.params.width
		114	[633]	TGETS	 11	0	83	; slot11 = self.params
		115	[633]	TGETS	 11	11	70	; slot11 = self.params.height
		116	[633]	CALL 	  8	1	4	;  = loading.init(loading, self.params.width, self.params.height)
		117	[634]	MOV  	  9		6	; slot9 = loading
		118	[634]	TGETS	  8	6	69	; slot8 = loading.close
		119	[634]	CALL 	  8	1	2	;  = loading.close(loading)
		120	[635]	TGETS	  8	0	67	; slot8 = self.active_item
		121	[635]	TSETS	  8	0	68	; self.queue_unload_item = self.active_item
		122	[636]	TSETS	  6	0	67	; self.active_item = loading
		123	[639]	TGETS	  6	4	98	; slot6 = props.type
		124	[639]	ISNES	  6		66	; if props.type ~= "screen"
		125	[639]	JMP  	  6		43	; 	goto 169
		126	[640]	MOV  	  6		3	; slot6 = _require
		127	[640]	TGETS	  7	4	65	; slot7 = props.src
		128	[640]	TGETS	  8	0	96	; slot8 = self.next_item_args
		129	[640]	ISF  	   		8	; if not self.next_item_args
		130	[640]	JMP  	  9		2	; 	goto 133
		131	[640]	TGETS	  8	0	96	; slot8 = self.next_item_args
		132	[640]	TGETS	  8	8	64	; slot8 = self.next_item_args.force_reload
		133	[640]	CALL 	  6	2	3	; slot6 = _require(props.src, self.next_item_args.force_reload)
		134	[641]	TSETS	  1	6	63	; item.item_name = name
		135	[642]	TGETS	  7	0	96	; slot7 = self.next_item_args
		136	[642]	TSETS	  7	6	62	; item.args = self.next_item_args
		137	[643]	TGETS	  7	6	76	; slot7 = item.required_textures
		138	[643]	ISF  	   		7	; if not item.required_textures
		139	[643]	JMP  	  8		11	; 	goto 151
		140	[644]	MOV  	  8		0	; slot8 = self
		141	[644]	TGETS	  7	0	85	; slot7 = self.load_texture_groups
		142	[644]	UGET 	  9		3	; slot9 = uv3"replace_locale"
		143	[644]	TGETS	 10	6	76	; slot10 = item.required_textures
		144	[644]	CALL 	  9	2	2	; slot9 = uv3"replace_locale"(item.required_textures)
		145	[645]	TGETS	 10	0	83	; slot10 = self.params
		146	[645]	TGETS	 10	10	82	; slot10 = self.params.texture_size
		147	[645]	TGETS	 11	6	75	; slot11 = item.ref_res
		148	[645]	KPRI 	 12		2	; slot12 = true
		149	[645]	MOV  	 13		1	; slot13 = name
		150	[644]	CALL 	  7	1	7	;  = self.load_texture_groups(self, uv3"replace_locale", self.params.texture_size, item.ref_res, slot12, name)
		151	[647]	TGETS	  7	6	75	; slot7 = item.ref_res
		152	[647]	ISF  	   		7	; if not item.ref_res
		153	[647]	JMP  	  8		6	; 	goto 160
		154	[648]	MOV  	  8		0	; slot8 = self
		155	[648]	TGETS	  7	0	60	; slot7 = self.get_texture_scale
		156	[648]	MOV  	  9		1	; slot9 = name
		157	[648]	TGETS	 10	6	75	; slot10 = item.ref_res
		158	[648]	CALL 	  7	2	4	; slot7 = self.get_texture_scale(self, name, item.ref_res)
		159	[648]	TSETS	  7	6	61	; item.screen_scale = self.get_texture_scale
		160	[650]	TSETS	  6	0	59	; self.queued_item = item
		161	[651]	TGETS	  7	6	74	; slot7 = item.required_sounds
		162	[651]	ISF  	   		7	; if not item.required_sounds
		163	[651]	JMP  	  8		537	; 	goto 701
		164	[652]	MOV  	  8		0	; slot8 = self
		165	[652]	TGETS	  7	0	73	; slot7 = self.load_sound_groups
		166	[652]	TGETS	  9	6	74	; slot9 = item.required_sounds
		167	[652]	CALL 	  7	1	3	;  = self.load_sound_groups(self, item.required_sounds)
		168	[653]	JMP  	  6		532	; 	goto 701
		169	[655]	TGETS	  6	4	98	; slot6 = props.type
		170	[655]	ISNES	  6		58	; if props.type ~= "comic"
		171	[655]	JMP  	  6		36	; 	goto 208
		172	[656]	TGETS	  6	0	96	; slot6 = self.next_item_args
		173	[657]	TGETS	  7	6	57	; slot7 = args.custom
		174	[659]	MOV  	  8		3	; slot8 = _require
		175	[659]	KSTR 	  9		56	; slot9 = "screen_comics"
		176	[659]	CALL 	  8	2	2	; slot8 = _require(slot9)
		177	[660]	KSTR 	  9		55	; slot9 = "comics"
		178	[660]	TSETS	  9	8	63	; item.item_name = slot9
		179	[661]	TSETS	  7	8	54	; item.comic_idx = comic_idx
		180	[662]	TDUP 	  9		53	; slot9 = copy table#k53
		181	[662]	KSTR 	 10		52	; slot10 = "comic_"
		182	[662]	MOV  	 11		7	; slot11 = comic_idx
		183	[662]	CAT  	 10	10	11	; slot10 = slot10 .. comic_idx
		184	[662]	TSETB	 10	9	2	; slot9[2] = slot10
		185	[662]	TSETS	  9	8	76	; item.required_textures = slot9
		186	[663]	MOV  	 10		0	; slot10 = self
		187	[663]	TGETS	  9	0	51	; slot9 = self.get_comic_data_file
		188	[663]	MOV  	 11		7	; slot11 = comic_idx
		189	[663]	CALL 	  9	2	3	; slot9 = self.get_comic_data_file(self, comic_idx)
		190	[664]	GGET 	 10		49	; slot10 = _env["love"]
		191	[664]	TGETS	 10	10	48	; slot10 = love.filesystem
		192	[664]	TGETS	 10	10	47	; slot10 = love.filesystem.read
		193	[664]	MOV  	 11		9	; slot11 = comic_data_file
		194	[664]	CALL 	 10	2	2	; slot10 = love.filesystem.read(comic_data_file)
		195	[664]	TSETS	 10	8	50	; item.comic_data = love.filesystem.read
		196	[665]	MOV  	 11		0	; slot11 = self
		197	[665]	TGETS	 10	0	85	; slot10 = self.load_texture_groups
		198	[665]	UGET 	 12		3	; slot12 = uv3"replace_locale"
		199	[665]	TGETS	 13	8	76	; slot13 = item.required_textures
		200	[665]	CALL 	 12	2	2	; slot12 = uv3"replace_locale"(item.required_textures)
		201	[665]	TGETS	 13	0	83	; slot13 = self.params
		202	[665]	TGETS	 13	13	82	; slot13 = self.params.texture_size
		203	[665]	TGETS	 14	8	75	; slot14 = item.ref_res
		204	[665]	KPRI 	 15		2	; slot15 = true
		205	[665]	CALL 	 10	1	6	;  = self.load_texture_groups(self, uv3"replace_locale", self.params.texture_size, item.ref_res, slot15)
		206	[666]	TSETS	  8	0	59	; self.queued_item = item
		207	[666]	JMP  	  6		493	; 	goto 701
		208	[668]	TGETS	  6	4	98	; slot6 = props.type
		209	[668]	ISNES	  6		97	; if props.type ~= "game"
		210	[668]	JMP  	  6		490	; 	goto 701
		211	[669]	MOV  	  6		3	; slot6 = _require
		212	[669]	KSTR 	  7		46	; slot7 = "game_gui"
		213	[669]	CALL 	  6	2	2	; slot6 = _require(slot7)
		214	[670]	MOV  	  7		3	; slot7 = _require
		215	[670]	KSTR 	  8		97	; slot8 = "game"
		216	[670]	CALL 	  7	2	2	; slot7 = _require(slot8)
		217	[672]	KSTR 	  8		97	; slot8 = "game"
		218	[672]	TSETS	  8	7	63	; game.item_name = slot8
		219	[673]	GGET 	  8		44	; slot8 = _env["DRAW_FPS"]
		220	[673]	TSETS	  8	7	45	; game.max_fps = DRAW_FPS
		221	[675]	TGETS	  8	0	96	; slot8 = self.next_item_args
		222	[676]	TNEW 	  9		0	; slot9 = new table( array: 0, dict: 1)
		223	[676]	TSETS	  9	7	78	; game.store = slot9
		224	[677]	TGETS	  9	7	78	; slot9 = game.store
		225	[677]	TGETS	 10	8	95	; slot10 = args.level_idx
		226	[677]	TSETS	 10	9	95	; game.store.level_idx = args.level_idx
		227	[678]	TGETS	  9	7	78	; slot9 = game.store
		228	[678]	KSTR 	 10		42	; slot10 = "level"
		229	[678]	GGET 	 11		94	; slot11 = _env["string"]
		230	[678]	TGETS	 11	11	93	; slot11 = string.format
		231	[678]	KSTR 	 12		41	; slot12 = "%02i"
		232	[678]	TGETS	 13	8	95	; slot13 = args.level_idx
		233	[678]	CALL 	 11	2	3	; slot11 = string.format(slot12, args.level_idx)
		234	[678]	CAT  	 10	10	11	; slot10 = slot10 .. string.format
		235	[678]	TSETS	 10	9	43	; game.store.level_name = slot10
		236	[679]	TGETS	  9	7	78	; slot9 = game.store
		237	[679]	TGETS	 10	8	91	; slot10 = args.level_mode
		238	[679]	TSETS	 10	9	91	; game.store.level_mode = args.level_mode
		239	[680]	TGETS	  9	7	78	; slot9 = game.store
		240	[680]	TGETS	 10	8	40	; slot10 = args.level_challenge
		241	[680]	TSETS	 10	9	40	; game.store.level_challenge = args.level_challenge
		242	[681]	TGETS	  9	7	78	; slot9 = game.store
		243	[681]	TGETS	 10	8	39	; slot10 = args.level_difficulty
		244	[681]	TSETS	 10	9	39	; game.store.level_difficulty = args.level_difficulty
		245	[682]	TGETS	  9	7	78	; slot9 = game.store
		246	[682]	MOV  	 11		0	; slot11 = self
		247	[682]	TGETS	 10	0	60	; slot10 = self.get_texture_scale
		248	[682]	KSTR 	 12		97	; slot12 = "game"
		249	[682]	GGET 	 13		38	; slot13 = _env["REF_H"]
		250	[682]	CALL 	 10	2	4	; slot10 = self.get_texture_scale(self, slot12, REF_H)
		251	[682]	TSETS	 10	9	61	; game.store.screen_scale = self.get_texture_scale
		252	[683]	TGETS	  9	7	78	; slot9 = game.store
		253	[683]	TGETS	 10	0	83	; slot10 = self.params
		254	[683]	TGETS	 10	10	82	; slot10 = self.params.texture_size
		255	[683]	TSETS	 10	9	82	; game.store.texture_size = self.params.texture_size
		256	[685]	TGETS	  9	8	37	; slot9 = args.extra
		257	[685]	ISF  	   		9	; if not args.extra
		258	[685]	JMP  	 10		32	; 	goto 291
		259	[686]	TGETS	  9	8	37	; slot9 = args.extra
		260	[686]	TGETS	  9	9	36	; slot9 = args.extra.extra_heroes
		261	[686]	ISF  	   		9	; if not args.extra.extra_heroes
		262	[686]	JMP  	 10		4	; 	goto 267
		263	[687]	TGETS	  9	7	78	; slot9 = game.store
		264	[687]	TGETS	 10	8	37	; slot10 = args.extra
		265	[687]	TGETS	 10	10	36	; slot10 = args.extra.extra_heroes
		266	[687]	TSETS	 10	9	36	; game.store.extra_heroes = args.extra.extra_heroes
		267	[689]	TGETS	  9	8	37	; slot9 = args.extra
		268	[689]	TGETS	  9	9	35	; slot9 = args.extra.override_heroes
		269	[689]	ISF  	   		9	; if not args.extra.override_heroes
		270	[689]	JMP  	 10		4	; 	goto 275
		271	[690]	TGETS	  9	7	78	; slot9 = game.store
		272	[690]	TGETS	 10	8	37	; slot10 = args.extra
		273	[690]	TGETS	 10	10	35	; slot10 = args.extra.override_heroes
		274	[690]	TSETS	 10	9	35	; game.store.override_heroes = args.extra.override_heroes
		275	[692]	TGETS	  9	8	37	; slot9 = args.extra
		276	[692]	TGETS	  9	9	34	; slot9 = args.extra.override_towers
		277	[692]	ISF  	   		9	; if not args.extra.override_towers
		278	[692]	JMP  	 10		4	; 	goto 283
		279	[693]	TGETS	  9	7	78	; slot9 = game.store
		280	[693]	TGETS	 10	8	37	; slot10 = args.extra
		281	[693]	TGETS	 10	10	34	; slot10 = args.extra.override_towers
		282	[693]	TSETS	 10	9	34	; game.store.override_towers = args.extra.override_towers
		283	[695]	TGETS	  9	8	37	; slot9 = args.extra
		284	[695]	TGETS	  9	9	33	; slot9 = args.extra.override_powers
		285	[695]	ISF  	   		9	; if not args.extra.override_powers
		286	[695]	JMP  	 10		4	; 	goto 291
		287	[696]	TGETS	  9	7	78	; slot9 = game.store
		288	[696]	TGETS	 10	8	37	; slot10 = args.extra
		289	[696]	TGETS	 10	10	33	; slot10 = args.extra.override_powers
		290	[696]	TSETS	 10	9	33	; game.store.override_powers = args.extra.override_powers
		291	[701]	UGET 	  9		1	; slot9 = uv1"log"
		292	[701]	TGETS	  9	9	90	; slot9 = uv1"log".start_time
		293	[701]	KSTR 	 10		32	; slot10 = "level_data"
		294	[701]	CALL 	  9	1	2	;  = uv1"log".start_time(slot10)
		295	[702]	TGETS	  9	7	78	; slot9 = game.store
		296	[702]	UGET 	 10		4	; slot10 = uv4"LU"
		297	[702]	TGETS	 10	10	31	; slot10 = uv4"LU".load_level
		298	[702]	TGETS	 11	7	78	; slot11 = game.store
		299	[702]	TGETS	 12	7	78	; slot12 = game.store
		300	[702]	TGETS	 12	12	43	; slot12 = game.store.level_name
		301	[702]	CALL 	 10	2	3	; slot10 = uv4"LU".load_level(game.store, game.store.level_name)
		302	[702]	TSETS	 10	9	42	; game.store.level = uv4"LU".load_level
		303	[703]	UGET 	  9		1	; slot9 = uv1"log"
		304	[703]	TGETS	  9	9	30	; slot9 = uv1"log".end_time
		305	[703]	KSTR 	 10		32	; slot10 = "level_data"
		306	[703]	CALL 	  9	1	2	;  = uv1"log".end_time(slot10)
		307	[706]	MOV  	 10		0	; slot10 = self
		308	[706]	TGETS	  9	0	85	; slot9 = self.load_texture_groups
		309	[706]	UGET 	 11		3	; slot11 = uv3"replace_locale"
		310	[706]	TGETS	 12	7	76	; slot12 = game.required_textures
		311	[706]	CALL 	 11	2	2	; slot11 = uv3"replace_locale"(game.required_textures)
		312	[706]	TGETS	 12	0	83	; slot12 = self.params
		313	[706]	TGETS	 12	12	82	; slot12 = self.params.texture_size
		314	[706]	TGETS	 13	7	75	; slot13 = game.ref_res
		315	[706]	KPRI 	 14		2	; slot14 = true
		316	[706]	KSTR 	 15		97	; slot15 = "game"
		317	[706]	CALL 	  9	1	7	;  = self.load_texture_groups(self, uv3"replace_locale", self.params.texture_size, game.ref_res, slot14, slot15)
		318	[707]	MOV  	 10		0	; slot10 = self
		319	[707]	TGETS	  9	0	85	; slot9 = self.load_texture_groups
		320	[707]	UGET 	 11		3	; slot11 = uv3"replace_locale"
		321	[707]	TGETS	 12	7	78	; slot12 = game.store
		322	[707]	TGETS	 12	12	42	; slot12 = game.store.level
		323	[707]	TGETS	 12	12	76	; slot12 = game.store.level.required_textures
		324	[707]	CALL 	 11	2	2	; slot11 = uv3"replace_locale"(game.store.level.required_textures)
		325	[707]	TGETS	 12	0	83	; slot12 = self.params
		326	[707]	TGETS	 12	12	82	; slot12 = self.params.texture_size
		327	[707]	TGETS	 13	7	75	; slot13 = game.ref_res
		328	[707]	KPRI 	 14		2	; slot14 = true
		329	[707]	KSTR 	 15		97	; slot15 = "game"
		330	[707]	CALL 	  9	1	7	;  = self.load_texture_groups(self, uv3"replace_locale", self.params.texture_size, game.ref_res, slot14, slot15)
		331	[708]	MOV  	 10		0	; slot10 = self
		332	[708]	TGETS	  9	0	85	; slot9 = self.load_texture_groups
		333	[708]	UGET 	 11		3	; slot11 = uv3"replace_locale"
		334	[708]	TGETS	 12	6	76	; slot12 = game_gui.required_textures
		335	[708]	CALL 	 11	2	2	; slot11 = uv3"replace_locale"(game_gui.required_textures)
		336	[708]	TGETS	 12	0	83	; slot12 = self.params
		337	[708]	TGETS	 12	12	82	; slot12 = self.params.texture_size
		338	[708]	TGETS	 13	6	75	; slot13 = game_gui.ref_res
		339	[708]	KPRI 	 14		2	; slot14 = true
		340	[708]	KSTR 	 15		46	; slot15 = "game_gui"
		341	[708]	CALL 	  9	1	7	;  = self.load_texture_groups(self, uv3"replace_locale", self.params.texture_size, game_gui.ref_res, slot14, slot15)
		342	[711]	MOV  	 10		0	; slot10 = self
		343	[711]	TGETS	  9	0	73	; slot9 = self.load_sound_groups
		344	[711]	TGETS	 11	7	74	; slot11 = game.required_sounds
		345	[711]	CALL 	  9	1	3	;  = self.load_sound_groups(self, game.required_sounds)
		346	[712]	MOV  	 10		0	; slot10 = self
		347	[712]	TGETS	  9	0	73	; slot9 = self.load_sound_groups
		348	[712]	TGETS	 11	7	78	; slot11 = game.store
		349	[712]	TGETS	 11	11	42	; slot11 = game.store.level
		350	[712]	TGETS	 11	11	74	; slot11 = game.store.level.required_sounds
		351	[712]	CALL 	  9	1	3	;  = self.load_sound_groups(self, game.store.level.required_sounds)
		352	[714]	UGET 	  9		5	; slot9 = uv5"storage"
		353	[714]	MOV  	 10		9	; slot10 = uv5"storage"
		354	[714]	TGETS	  9	9	29	; slot9 = uv5"storage".load_slot
		355	[714]	CALL 	  9	2	2	; slot9 = uv5"storage".load_slot(uv5"storage")
		356	[715]	TNEW 	 10		0	; slot10 = new table( array: 0, dict: 1)
		357	[716]	TGETS	 11	9	28	; slot11 = slot.heroes
		358	[716]	TGETS	 11	11	27	; slot11 = slot.heroes.team
		359	[716]	ISF  	   		11	; if not slot.heroes.team
		360	[716]	JMP  	 12		7	; 	goto 368
		361	[717]	GGET 	 11		26	; slot11 = _env["table"]
		362	[717]	TGETS	 11	11	25	; slot11 = table.append
		363	[717]	MOV  	 12		10	; slot12 = heroes
		364	[717]	TGETS	 13	9	28	; slot13 = slot.heroes
		365	[717]	TGETS	 13	13	27	; slot13 = slot.heroes.team
		366	[717]	CALL 	 11	1	3	;  = table.append(heroes, slot.heroes.team)
		367	[717]	JMP  	 11		29	; 	goto 397
		368	[718]	TGETS	 11	9	28	; slot11 = slot.heroes
		369	[718]	TGETS	 11	11	24	; slot11 = slot.heroes.selected
		370	[718]	ISF  	   		11	; if not slot.heroes.selected
		371	[718]	JMP  	 12		25	; 	goto 397
		372	[719]	TGETS	 11	8	40	; slot11 = args.level_challenge
		373	[719]	ISF  	   		11	; if not args.level_challenge
		374	[719]	JMP  	 12		16	; 	goto 391
		375	[719]	TGETS	 11	8	40	; slot11 = args.level_challenge
		376	[719]	TGETS	 11	11	23	; slot11 = args.level_challenge.restrictions
		377	[719]	ISF  	   		11	; if not args.level_challenge.restrictions
		378	[719]	JMP  	 12		12	; 	goto 391
		379	[719]	TGETS	 11	8	40	; slot11 = args.level_challenge
		380	[719]	TGETS	 11	11	23	; slot11 = args.level_challenge.restrictions
		381	[719]	TGETS	 11	11	22	; slot11 = args.level_challenge.restrictions.forced_hero
		382	[719]	ISF  	   		11	; if not args.level_challenge.restrictions.forced_hero
		383	[719]	JMP  	 12		7	; 	goto 391
		384	[720]	TNEW 	 11		3	; slot11 = new table( array: 3, dict: 1)
		385	[720]	TGETS	 12	8	40	; slot12 = args.level_challenge
		386	[720]	TGETS	 12	12	23	; slot12 = args.level_challenge.restrictions
		387	[720]	TGETS	 12	12	22	; slot12 = args.level_challenge.restrictions.forced_hero
		388	[720]	TSETB	 12	11	1	; slot11[1] = args.level_challenge.restrictions.forced_hero
		389	[720]	MOV  	 10		11	; slot10 = slot11
		390	[720]	JMP  	 11		6	; 	goto 397
		391	[722]	GGET 	 11		26	; slot11 = _env["table"]
		392	[722]	TGETS	 11	11	21	; slot11 = table.insert
		393	[722]	MOV  	 12		10	; slot12 = heroes
		394	[722]	TGETS	 13	9	28	; slot13 = slot.heroes
		395	[722]	TGETS	 13	13	24	; slot13 = slot.heroes.selected
		396	[722]	CALL 	 11	1	3	;  = table.insert(heroes, slot.heroes.selected)
		397	[725]	TGETS	 11	7	78	; slot11 = game.store
		398	[725]	TGETS	 11	11	35	; slot11 = game.store.override_heroes
		399	[725]	ISF  	   		11	; if not game.store.override_heroes
		400	[725]	JMP  	 12		13	; 	goto 414
		401	[726]	TNEW 	 10		0	; slot10 = new table( array: 0, dict: 1)
		402	[727]	GGET 	 11		20	; slot11 = _env["ipairs"]
		403	[727]	TGETS	 12	7	78	; slot12 = game.store
		404	[727]	TGETS	 12	12	35	; slot12 = game.store.override_heroes
		405	[727]	CALL 	 11	4	2	; slot11, slot12, slot13 = ipairs(game.store.override_heroes)
		406	[727]	JMP  	 14		5	; 	goto 412
		407	[728]	GGET 	 16		26	; slot16 = _env["table"]
		408	[728]	TGETS	 16	16	21	; slot16 = table.insert
		409	[728]	MOV  	 17		10	; slot17 = heroes
		410	[728]	MOV  	 18		15	; slot18 = hero
		411	[728]	CALL 	 16	1	3	;  = table.insert(heroes, hero)
		412	[727]	ITERC	 14	3	3	; slot14, slot15, slot16 = slot11<generator>, slot12<state>, slot13<control>; slot14, slot15 = slot11<generator>(slot12<state>, slot13<control>)
		413	[727]	ITERL	 14		-7	; slot13<control> = slot14; if slot14 != nil goto 407
		414	[731]	TGETS	 11	7	78	; slot11 = game.store
		415	[731]	TGETS	 11	11	36	; slot11 = game.store.extra_heroes
		416	[731]	ISF  	   		11	; if not game.store.extra_heroes
		417	[731]	JMP  	 12		12	; 	goto 430
		418	[732]	GGET 	 11		19	; slot11 = _env["pairs"]
		419	[732]	TGETS	 12	7	78	; slot12 = game.store
		420	[732]	TGETS	 12	12	36	; slot12 = game.store.extra_heroes
		421	[732]	CALL 	 11	4	2	; slot11, slot12, slot13 = pairs(game.store.extra_heroes)
		422	[732]	ISNEXT	 14		5	; Verify ITERN at 428; goto 428
		423	[733]	GGET 	 16		26	; slot16 = _env["table"]
		424	[733]	TGETS	 16	16	21	; slot16 = table.insert
		425	[733]	MOV  	 17		10	; slot17 = heroes
		426	[733]	MOV  	 18		15	; slot18 = v
		427	[733]	CALL 	 16	1	3	;  = table.insert(heroes, v)
		428	[732]	ITERN	 14	3	3	; slot14, slot15, slot16 = slot11<generator>, slot12<state>, slot13<control>; slot14, slot15 = slot11<generator>(slot12<state>, slot13<control>)
		429	[732]	ITERL	 14		-7	; slot13<control> = slot14; if slot14 != nil goto 423
		430	[737]	GGET 	 11		20	; slot11 = _env["ipairs"]
		431	[737]	MOV  	 12		10	; slot12 = heroes
		432	[737]	CALL 	 11	4	2	; slot11, slot12, slot13 = ipairs(heroes)
		433	[737]	JMP  	 14		19	; 	goto 453
		434	[738]	TNEW 	 16		3	; slot16 = new table( array: 3, dict: 1)
		435	[738]	KSTR 	 17		18	; slot17 = "go_"
		436	[738]	MOV  	 18		15	; slot18 = hero
		437	[738]	CAT  	 17	17	18	; slot17 = slot17 .. hero
		438	[738]	TSETB	 17	16	1	; slot16[1] = slot17
		439	[739]	MOV  	 18		0	; slot18 = self
		440	[739]	TGETS	 17	0	85	; slot17 = self.load_texture_groups
		441	[739]	MOV  	 19		16	; slot19 = hero_textures
		442	[739]	TGETS	 20	0	83	; slot20 = self.params
		443	[739]	TGETS	 20	20	82	; slot20 = self.params.texture_size
		444	[739]	TGETS	 21	7	75	; slot21 = game.ref_res
		445	[739]	KPRI 	 22		2	; slot22 = true
		446	[739]	KSTR 	 23		97	; slot23 = "game"
		447	[739]	CALL 	 17	1	7	;  = self.load_texture_groups(self, hero_textures, self.params.texture_size, game.ref_res, slot22, slot23)
		448	[740]	MOV  	 18		0	; slot18 = self
		449	[740]	TGETS	 17	0	73	; slot17 = self.load_sound_groups
		450	[740]	TNEW 	 19		3	; slot19 = new table( array: 3, dict: 1)
		451	[740]	TSETB	 15	19	1	; slot19[1] = hero
		452	[740]	CALL 	 17	1	3	;  = self.load_sound_groups(self, slot19)
		453	[737]	ITERC	 14	3	3	; slot14, slot15, slot16 = slot11<generator>, slot12<state>, slot13<control>; slot14, slot15 = slot11<generator>(slot12<state>, slot13<control>)
		454	[737]	ITERL	 14		-21	; slot13<control> = slot14; if slot14 != nil goto 434
		455	[743]	TNEW 	 11		0	; slot11 = new table( array: 0, dict: 1)
		456	[744]	TGETS	 12	9	17	; slot12 = slot.towers
		457	[744]	ISF  	   		12	; if not slot.towers
		458	[744]	JMP  	 13		40	; 	goto 499
		459	[744]	TGETS	 12	9	17	; slot12 = slot.towers
		460	[744]	TGETS	 12	12	24	; slot12 = slot.towers.selected
		461	[744]	ISF  	   		12	; if not slot.towers.selected
		462	[744]	JMP  	 13		36	; 	goto 499
		463	[745]	TGETS	 12	7	78	; slot12 = game.store
		464	[745]	TGETS	 12	12	42	; slot12 = game.store.level
		465	[745]	TGETS	 12	12	16	; slot12 = game.store.level.available_towers
		466	[745]	ISF  	   		12	; if not game.store.level.available_towers
		467	[745]	JMP  	 13		19	; 	goto 487
		468	[747]	GGET 	 12		20	; slot12 = _env["ipairs"]
		469	[747]	TGETS	 13	7	78	; slot13 = game.store
		470	[747]	TGETS	 13	13	42	; slot13 = game.store.level
		471	[747]	TGETS	 13	13	16	; slot13 = game.store.level.available_towers
		472	[747]	CALL 	 12	4	2	; slot12, slot13, slot14 = ipairs(game.store.level.available_towers)
		473	[747]	JMP  	 15		10	; 	goto 484
		474	[748]	MOV  	 18		16	; slot18 = tower
		475	[748]	TGETS	 17	16	15	; slot17 = tower.gsub
		476	[748]	KSTR 	 19		14	; slot19 = "tower_build_"
		477	[748]	KSTR 	 20		13	; slot20 = ""
		478	[748]	CALL 	 17	2	4	; slot17 = tower.gsub(tower, slot19, slot20)
		479	[749]	GGET 	 18		26	; slot18 = _env["table"]
		480	[749]	TGETS	 18	18	21	; slot18 = table.insert
		481	[749]	MOV  	 19		11	; slot19 = towers
		482	[749]	MOV  	 20		17	; slot20 = tower_name
		483	[749]	CALL 	 18	1	3	;  = table.insert(towers, tower_name)
		484	[747]	ITERC	 15	3	3	; slot15, slot16, slot17 = slot12<generator>, slot13<state>, slot14<control>; slot15, slot16 = slot12<generator>(slot13<state>, slot14<control>)
		485	[747]	ITERL	 15		-12	; slot14<control> = slot15; if slot15 != nil goto 474
		486	[750]	JMP  	 12		12	; 	goto 499
		487	[753]	GGET 	 12		20	; slot12 = _env["ipairs"]
		488	[753]	TGETS	 13	9	17	; slot13 = slot.towers
		489	[753]	TGETS	 13	13	24	; slot13 = slot.towers.selected
		490	[753]	CALL 	 12	4	2	; slot12, slot13, slot14 = ipairs(slot.towers.selected)
		491	[753]	JMP  	 15		5	; 	goto 497
		492	[754]	GGET 	 17		26	; slot17 = _env["table"]
		493	[754]	TGETS	 17	17	21	; slot17 = table.insert
		494	[754]	MOV  	 18		11	; slot18 = towers
		495	[754]	MOV  	 19		16	; slot19 = tower
		496	[754]	CALL 	 17	1	3	;  = table.insert(towers, tower)
		497	[753]	ITERC	 15	3	3	; slot15, slot16, slot17 = slot12<generator>, slot13<state>, slot14<control>; slot15, slot16 = slot12<generator>(slot13<state>, slot14<control>)
		498	[753]	ITERL	 15		-7	; slot14<control> = slot15; if slot15 != nil goto 492
		499	[758]	TGETS	 12	7	78	; slot12 = game.store
		500	[758]	TGETS	 12	12	34	; slot12 = game.store.override_towers
		501	[758]	ISF  	   		12	; if not game.store.override_towers
		502	[758]	JMP  	 13		13	; 	goto 516
		503	[759]	TNEW 	 11		0	; slot11 = new table( array: 0, dict: 1)
		504	[760]	GGET 	 12		20	; slot12 = _env["ipairs"]
		505	[760]	TGETS	 13	7	78	; slot13 = game.store
		506	[760]	TGETS	 13	13	34	; slot13 = game.store.override_towers
		507	[760]	CALL 	 12	4	2	; slot12, slot13, slot14 = ipairs(game.store.override_towers)
		508	[760]	JMP  	 15		5	; 	goto 514
		509	[761]	GGET 	 17		26	; slot17 = _env["table"]
		510	[761]	TGETS	 17	17	21	; slot17 = table.insert
		511	[761]	MOV  	 18		11	; slot18 = towers
		512	[761]	MOV  	 19		16	; slot19 = tower
		513	[761]	CALL 	 17	1	3	;  = table.insert(towers, tower)
		514	[760]	ITERC	 15	3	3	; slot15, slot16, slot17 = slot12<generator>, slot13<state>, slot14<control>; slot15, slot16 = slot12<generator>(slot13<state>, slot14<control>)
		515	[760]	ITERL	 15		-7	; slot14<control> = slot15; if slot15 != nil goto 509
		516	[765]	GGET 	 12		20	; slot12 = _env["ipairs"]
		517	[765]	MOV  	 13		11	; slot13 = towers
		518	[765]	CALL 	 12	4	2	; slot12, slot13, slot14 = ipairs(towers)
		519	[765]	JMP  	 15		22	; 	goto 542
		520	[766]	TNEW 	 17		3	; slot17 = new table( array: 3, dict: 1)
		521	[766]	KSTR 	 18		12	; slot18 = "go_towers_"
		522	[766]	MOV  	 19		16	; slot19 = tower
		523	[766]	CAT  	 18	18	19	; slot18 = slot18 .. tower
		524	[766]	TSETB	 18	17	1	; slot17[1] = slot18
		525	[767]	MOV  	 19		0	; slot19 = self
		526	[767]	TGETS	 18	0	85	; slot18 = self.load_texture_groups
		527	[767]	MOV  	 20		17	; slot20 = tower_texture
		528	[767]	TGETS	 21	0	83	; slot21 = self.params
		529	[767]	TGETS	 21	21	82	; slot21 = self.params.texture_size
		530	[767]	TGETS	 22	7	75	; slot22 = game.ref_res
		531	[767]	KPRI 	 23		2	; slot23 = true
		532	[767]	KSTR 	 24		97	; slot24 = "game"
		533	[767]	CALL 	 18	1	7	;  = self.load_texture_groups(self, tower_texture, self.params.texture_size, game.ref_res, slot23, slot24)
		534	[768]	MOV  	 19		0	; slot19 = self
		535	[768]	TGETS	 18	0	73	; slot18 = self.load_sound_groups
		536	[768]	TNEW 	 20		3	; slot20 = new table( array: 3, dict: 1)
		537	[768]	KSTR 	 21		11	; slot21 = "tower_"
		538	[768]	MOV  	 22		16	; slot22 = tower
		539	[768]	CAT  	 21	21	22	; slot21 = slot21 .. tower
		540	[768]	TSETB	 21	20	1	; slot20[1] = slot21
		541	[768]	CALL 	 18	1	3	;  = self.load_sound_groups(self, slot20)
		542	[765]	ITERC	 15	3	3	; slot15, slot16, slot17 = slot12<generator>, slot13<state>, slot14<control>; slot15, slot16 = slot12<generator>(slot13<state>, slot14<control>)
		543	[765]	ITERL	 15		-24	; slot14<control> = slot15; if slot15 != nil goto 520
		544	[771]	TGETS	 12	9	10	; slot12 = slot.items
		545	[771]	ISF  	   		12	; if not slot.items
		546	[771]	JMP  	 13		33	; 	goto 580
		547	[771]	TGETS	 12	9	10	; slot12 = slot.items
		548	[771]	TGETS	 12	12	24	; slot12 = slot.items.selected
		549	[771]	ISF  	   		12	; if not slot.items.selected
		550	[771]	JMP  	 13		29	; 	goto 580
		551	[772]	GGET 	 12		20	; slot12 = _env["ipairs"]
		552	[772]	TGETS	 13	9	10	; slot13 = slot.items
		553	[772]	TGETS	 13	13	24	; slot13 = slot.items.selected
		554	[772]	CALL 	 12	4	2	; slot12, slot13, slot14 = ipairs(slot.items.selected)
		555	[772]	JMP  	 15		22	; 	goto 578
		556	[773]	TNEW 	 17		3	; slot17 = new table( array: 3, dict: 1)
		557	[773]	KSTR 	 18		9	; slot18 = "go_items_"
		558	[773]	MOV  	 19		16	; slot19 = item
		559	[773]	CAT  	 18	18	19	; slot18 = slot18 .. item
		560	[773]	TSETB	 18	17	1	; slot17[1] = slot18
		561	[774]	MOV  	 19		0	; slot19 = self
		562	[774]	TGETS	 18	0	85	; slot18 = self.load_texture_groups
		563	[774]	MOV  	 20		17	; slot20 = item_texture
		564	[774]	TGETS	 21	0	83	; slot21 = self.params
		565	[774]	TGETS	 21	21	82	; slot21 = self.params.texture_size
		566	[774]	TGETS	 22	7	75	; slot22 = game.ref_res
		567	[774]	KPRI 	 23		2	; slot23 = true
		568	[774]	KSTR 	 24		97	; slot24 = "game"
		569	[774]	CALL 	 18	1	7	;  = self.load_texture_groups(self, item_texture, self.params.texture_size, game.ref_res, slot23, slot24)
		570	[775]	MOV  	 19		0	; slot19 = self
		571	[775]	TGETS	 18	0	73	; slot18 = self.load_sound_groups
		572	[775]	TNEW 	 20		3	; slot20 = new table( array: 3, dict: 1)
		573	[775]	KSTR 	 21		8	; slot21 = "item_"
		574	[775]	MOV  	 22		16	; slot22 = item
		575	[775]	CAT  	 21	21	22	; slot21 = slot21 .. item
		576	[775]	TSETB	 21	20	1	; slot20[1] = slot21
		577	[775]	CALL 	 18	1	3	;  = self.load_sound_groups(self, slot20)
		578	[772]	ITERC	 15	3	3	; slot15, slot16, slot17 = slot12<generator>, slot13<state>, slot14<control>; slot15, slot16 = slot12<generator>(slot13<state>, slot14<control>)
		579	[772]	ITERL	 15		-24	; slot14<control> = slot15; if slot15 != nil goto 556
		580	[779]	TNEW 	 12		0	; slot12 = new table( array: 0, dict: 1)
		581	[780]	TGETS	 13	9	7	; slot13 = slot.powers
		582	[780]	ISF  	   		13	; if not slot.powers
		583	[780]	JMP  	 14		16	; 	goto 600
		584	[780]	TGETS	 13	9	7	; slot13 = slot.powers
		585	[780]	TGETS	 13	13	24	; slot13 = slot.powers.selected
		586	[780]	ISF  	   		13	; if not slot.powers.selected
		587	[780]	JMP  	 14		12	; 	goto 600
		588	[781]	GGET 	 13		20	; slot13 = _env["ipairs"]
		589	[781]	TGETS	 14	9	7	; slot14 = slot.powers
		590	[781]	TGETS	 14	14	24	; slot14 = slot.powers.selected
		591	[781]	CALL 	 13	4	2	; slot13, slot14, slot15 = ipairs(slot.powers.selected)
		592	[781]	JMP  	 16		5	; 	goto 598
		593	[782]	GGET 	 18		26	; slot18 = _env["table"]
		594	[782]	TGETS	 18	18	21	; slot18 = table.insert
		595	[782]	MOV  	 19		12	; slot19 = powers
		596	[782]	MOV  	 20		17	; slot20 = power
		597	[782]	CALL 	 18	1	3	;  = table.insert(powers, power)
		598	[781]	ITERC	 16	3	3	; slot16, slot17, slot18 = slot13<generator>, slot14<state>, slot15<control>; slot16, slot17 = slot13<generator>(slot14<state>, slot15<control>)
		599	[781]	ITERL	 16		-7	; slot15<control> = slot16; if slot16 != nil goto 593
		600	[785]	TGETS	 13	7	78	; slot13 = game.store
		601	[785]	TGETS	 13	13	33	; slot13 = game.store.override_powers
		602	[785]	ISF  	   		13	; if not game.store.override_powers
		603	[785]	JMP  	 14		13	; 	goto 617
		604	[786]	TNEW 	 12		0	; slot12 = new table( array: 0, dict: 1)
		605	[787]	GGET 	 13		20	; slot13 = _env["ipairs"]
		606	[787]	TGETS	 14	7	78	; slot14 = game.store
		607	[787]	TGETS	 14	14	33	; slot14 = game.store.override_powers
		608	[787]	CALL 	 13	4	2	; slot13, slot14, slot15 = ipairs(game.store.override_powers)
		609	[787]	JMP  	 16		5	; 	goto 615
		610	[788]	GGET 	 18		26	; slot18 = _env["table"]
		611	[788]	TGETS	 18	18	21	; slot18 = table.insert
		612	[788]	MOV  	 19		12	; slot19 = powers
		613	[788]	MOV  	 20		17	; slot20 = power
		614	[788]	CALL 	 18	1	3	;  = table.insert(powers, power)
		615	[787]	ITERC	 16	3	3	; slot16, slot17, slot18 = slot13<generator>, slot14<state>, slot15<control>; slot16, slot17 = slot13<generator>(slot14<state>, slot15<control>)
		616	[787]	ITERL	 16		-7	; slot15<control> = slot16; if slot16 != nil goto 610
		617	[792]	GGET 	 13		20	; slot13 = _env["ipairs"]
		618	[792]	MOV  	 14		12	; slot14 = powers
		619	[792]	CALL 	 13	4	2	; slot13, slot14, slot15 = ipairs(powers)
		620	[792]	JMP  	 16		22	; 	goto 643
		621	[793]	TNEW 	 18		3	; slot18 = new table( array: 3, dict: 1)
		622	[793]	KSTR 	 19		6	; slot19 = "go_power_"
		623	[793]	MOV  	 20		17	; slot20 = power
		624	[793]	CAT  	 19	19	20	; slot19 = slot19 .. power
		625	[793]	TSETB	 19	18	1	; slot18[1] = slot19
		626	[794]	MOV  	 20		0	; slot20 = self
		627	[794]	TGETS	 19	0	85	; slot19 = self.load_texture_groups
		628	[794]	MOV  	 21		18	; slot21 = power_texture
		629	[794]	TGETS	 22	0	83	; slot22 = self.params
		630	[794]	TGETS	 22	22	82	; slot22 = self.params.texture_size
		631	[794]	TGETS	 23	7	75	; slot23 = game.ref_res
		632	[794]	KPRI 	 24		2	; slot24 = true
		633	[794]	KSTR 	 25		97	; slot25 = "game"
		634	[794]	CALL 	 19	1	7	;  = self.load_texture_groups(self, power_texture, self.params.texture_size, game.ref_res, slot24, slot25)
		635	[795]	MOV  	 20		0	; slot20 = self
		636	[795]	TGETS	 19	0	73	; slot19 = self.load_sound_groups
		637	[795]	TNEW 	 21		3	; slot21 = new table( array: 3, dict: 1)
		638	[795]	KSTR 	 22		5	; slot22 = "powers_"
		639	[795]	MOV  	 23		17	; slot23 = power
		640	[795]	CAT  	 22	22	23	; slot22 = slot22 .. power
		641	[795]	TSETB	 22	21	1	; slot21[1] = slot22
		642	[795]	CALL 	 19	1	3	;  = self.load_sound_groups(self, slot21)
		643	[792]	ITERC	 16	3	3	; slot16, slot17, slot18 = slot13<generator>, slot14<state>, slot15<control>; slot16, slot17 = slot13<generator>(slot14<state>, slot15<control>)
		644	[792]	ITERL	 16		-24	; slot15<control> = slot16; if slot16 != nil goto 621
		645	[798]	TGETS	 13	7	78	; slot13 = game.store
		646	[798]	TGETS	 13	13	42	; slot13 = game.store.level
		647	[798]	TGETS	 13	13	4	; slot13 = game.store.level.show_comic_idx
		648	[798]	ISF  	   		13	; if not game.store.level.show_comic_idx
		649	[798]	JMP  	 14		50	; 	goto 700
		650	[798]	TGETS	 13	7	78	; slot13 = game.store
		651	[798]	TGETS	 13	13	91	; slot13 = game.store.level_mode
		652	[798]	GGET 	 14		3	; slot14 = _env["GAME_MODE_CAMPAIGN"]
		653	[798]	ISNEV	 13		14	; if game.store.level_mode ~= GAME_MODE_CAMPAIGN
		654	[798]	JMP  	 13		45	; 	goto 700
		655	[798]	TGETS	 13	8	40	; slot13 = args.level_challenge
		656	[798]	IST  	   		13	; if args.level_challenge
		657	[798]	JMP  	 13		42	; 	goto 700
		658	[800]	TGETS	 13	7	78	; slot13 = game.store
		659	[800]	TGETS	 13	13	42	; slot13 = game.store.level
		660	[800]	TGETS	 13	13	4	; slot13 = game.store.level.show_comic_idx
		661	[802]	MOV  	 14		3	; slot14 = _require
		662	[802]	KSTR 	 15		56	; slot15 = "screen_comics"
		663	[802]	CALL 	 14	2	2	; slot14 = _require(slot15)
		664	[803]	KSTR 	 15		55	; slot15 = "comics"
		665	[803]	TSETS	 15	14	63	; item.item_name = slot15
		666	[804]	TSETS	 13	14	54	; item.comic_idx = comic_idx
		667	[805]	TNEW 	 15		3	; slot15 = new table( array: 3, dict: 1)
		668	[805]	KSTR 	 16		52	; slot16 = "comic_"
		669	[805]	MOV  	 17		13	; slot17 = comic_idx
		670	[805]	CAT  	 16	16	17	; slot16 = slot16 .. comic_idx
		671	[805]	TSETB	 16	15	1	; slot15[1] = slot16
		672	[805]	TSETS	 15	14	76	; item.required_textures = slot15
		673	[806]	TGETS	 15	7	78	; slot15 = game.store
		674	[806]	TGETS	 15	15	95	; slot15 = game.store.level_idx
		675	[806]	TSETS	 15	14	95	; item.level_idx = game.store.level_idx
		676	[807]	MOV  	 16		0	; slot16 = self
		677	[807]	TGETS	 15	0	51	; slot15 = self.get_comic_data_file
		678	[807]	MOV  	 17		13	; slot17 = comic_idx
		679	[807]	CALL 	 15	2	3	; slot15 = self.get_comic_data_file(self, comic_idx)
		680	[808]	GGET 	 16		49	; slot16 = _env["love"]
		681	[808]	TGETS	 16	16	48	; slot16 = love.filesystem
		682	[808]	TGETS	 16	16	47	; slot16 = love.filesystem.read
		683	[808]	MOV  	 17		15	; slot17 = comic_data_file
		684	[808]	CALL 	 16	2	2	; slot16 = love.filesystem.read(comic_data_file)
		685	[808]	TSETS	 16	14	50	; item.comic_data = love.filesystem.read
		686	[809]	MOV  	 17		0	; slot17 = self
		687	[809]	TGETS	 16	0	85	; slot16 = self.load_texture_groups
		688	[809]	UGET 	 18		3	; slot18 = uv3"replace_locale"
		689	[809]	TGETS	 19	14	76	; slot19 = item.required_textures
		690	[809]	CALL 	 18	2	2	; slot18 = uv3"replace_locale"(item.required_textures)
		691	[809]	TGETS	 19	0	83	; slot19 = self.params
		692	[809]	TGETS	 19	19	82	; slot19 = self.params.texture_size
		693	[809]	TGETS	 20	14	75	; slot20 = item.ref_res
		694	[809]	KPRI 	 21		2	; slot21 = true
		695	[809]	KSTR 	 22		58	; slot22 = "comic"
		696	[809]	CALL 	 16	1	7	;  = self.load_texture_groups(self, uv3"replace_locale", self.params.texture_size, item.ref_res, slot21, slot22)
		697	[810]	TSETS	 14	0	59	; self.queued_item = item
		698	[811]	TSETS	  7	14	2	; item.game_item = game
		699	[811]	JMP  	 13		1	; 	goto 701
		700	[814]	TSETS	  7	0	59	; self.queued_item = game
		701	[818]	UGET 	  6		1	; slot6 = uv1"log"
		702	[818]	TGETS	  6	6	1	; slot6 = uv1"log".debug
		703	[818]	KSTR 	  7		0	; slot7 = "queued item: %s"
		704	[818]	TGETS	  8	0	59	; slot8 = self.queued_item
		705	[818]	TGETS	  8	8	63	; slot8 = self.queued_item.item_name
		706	[818]	CALL 	  6	1	3	;  = uv1"log".debug(slot7, self.queued_item.item_name)
		707	[819]	UCLO 	  0		0	; nil uvs >= r0; goto 708
		708	[819]	RET0 	  0		1	; return
	 99	[579]	TSETS	 23	22	60	; director.queue_load_item_named = slot23
	100	[821]	GGET 	 22		99	; slot22 = _env["director"]
	101	[847]	FNEW 	 23		57	; @./all/director.lua:821-847: 5 args, 2 upvalues, 22 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	I
		;;;; variable info ;;;;
		  0-72:	self
		  0-72:	groups
		  0-72:	texture_size
		  0-72:	ref_height
		  0-72:	item_name
		  3-71:	<generator>
		  3-71:	<state>
		  3-71:	<control>
		  4-69:	_
		  4-69:	group
		  5-69:	forced_texture_size
		  12-53:	texture_path
		  27-53:	<generator>
		  27-53:	<state>
		  27-53:	<control>
		  28-51:	_
		  28-51:	v
		  54-69:	scale
		;;;; instructions ;;;;
		  1	[822]	GGET 	  5		14	; slot5 = _env["pairs"]
		  2	[822]	MOV  	  6		1	; slot6 = groups
		  3	[822]	CALL 	  5	4	2	; slot5, slot6, slot7 = pairs(groups)
		  4	[822]	ISNEXT	  8		65	; Verify ITERN at 70; goto 70
		  5	[823]	KPRI 	 10		0	; slot10 = nil
		  6	[824]	GGET 	 11		13	; slot11 = _env["KR_PATH_ASSETS_GAME_FALLBACK"]
		  7	[824]	ISF  	   		11	; if not KR_PATH_ASSETS_GAME_FALLBACK
		  8	[824]	JMP  	 12		45	; 	goto 54
		  9	[825]	GGET 	 11		12	; slot11 = _env["KR_PATH_ASSETS_GAME_TARGET"]
		 10	[825]	KSTR 	 12		11	; slot12 = "/images/"
		 11	[825]	MOV  	 13		2	; slot13 = texture_size
		 12	[825]	CAT  	 11	11	13	; slot11 = KR_PATH_ASSETS_GAME_TARGET .. slot12 .. texture_size
		 13	[826]	GGET 	 12		10	; slot12 = _env["love"]
		 14	[826]	TGETS	 12	12	9	; slot12 = love.filesystem
		 15	[826]	TGETS	 12	12	8	; slot12 = love.filesystem.exists
		 16	[826]	MOV  	 13		11	; slot13 = texture_path
		 17	[826]	KSTR 	 14		7	; slot14 = "/"
		 18	[826]	MOV  	 15		9	; slot15 = group
		 19	[826]	KSTR 	 16		6	; slot16 = ".lua"
		 20	[826]	CAT  	 13	13	16	; slot13 = texture_path .. slot14 .. group .. slot16
		 21	[826]	CALL 	 12	2	2	; slot12 = love.filesystem.exists(slot13)
		 22	[826]	ISF  	   		12	; if not love.filesystem.exists
		 23	[826]	JMP  	 13		1	; 	goto 25
		 24	[827]	JMP  	 11		29	; 	goto 54
		 25	[829]	GGET 	 12		14	; slot12 = _env["pairs"]
		 26	[829]	GGET 	 13		13	; slot13 = _env["KR_PATH_ASSETS_GAME_FALLBACK"]
		 27	[829]	CALL 	 12	4	2	; slot12, slot13, slot14 = pairs(KR_PATH_ASSETS_GAME_FALLBACK)
		 28	[829]	ISNEXT	 15		23	; Verify ITERN at 52; goto 52
		 29	[830]	TGETS	 17	16	5	; slot17 = v.path
		 30	[830]	KSTR 	 18		11	; slot18 = "/images/"
		 31	[830]	TGETS	 19	16	4	; slot19 = v.texture_size
		 32	[830]	CAT  	 11	17	19	; slot11 = v.path .. slot18 .. v.texture_size
		 33	[831]	GGET 	 17		10	; slot17 = _env["love"]
		 34	[831]	TGETS	 17	17	9	; slot17 = love.filesystem
		 35	[831]	TGETS	 17	17	8	; slot17 = love.filesystem.exists
		 36	[831]	MOV  	 18		11	; slot18 = texture_path
		 37	[831]	KSTR 	 19		7	; slot19 = "/"
		 38	[831]	MOV  	 20		9	; slot20 = group
		 39	[831]	KSTR 	 21		6	; slot21 = ".lua"
		 40	[831]	CAT  	 18	18	21	; slot18 = texture_path .. slot19 .. group .. slot21
		 41	[831]	CALL 	 17	2	2	; slot17 = love.filesystem.exists(slot18)
		 42	[831]	ISF  	   		17	; if not love.filesystem.exists
		 43	[831]	JMP  	 18		8	; 	goto 52
		 44	[832]	UGET 	 17		0	; slot17 = uv0"log"
		 45	[832]	TGETS	 17	17	3	; slot17 = uv0"log".debug
		 46	[832]	KSTR 	 18		2	; slot18 = " --- texture group %s fallback to %s"
		 47	[832]	MOV  	 19		9	; slot19 = group
		 48	[832]	MOV  	 20		11	; slot20 = texture_path
		 49	[832]	CALL 	 17	1	4	;  = uv0"log".debug(slot18, group, texture_path)
		 50	[833]	TGETS	 10	16	4	; slot10 = v.texture_size
		 51	[834]	JMP  	 11		2	; 	goto 54
		 52	[829]	ITERN	 15	3	3	; slot15, slot16, slot17 = slot12<generator>, slot13<state>, slot14<control>; slot15, slot16 = slot12<generator>(slot13<state>, slot14<control>)
		 53	[829]	ITERL	 15		-25	; slot14<control> = slot15; if slot15 != nil goto 29
		 54	[841]	KSHORT	 11		1	; slot11 = 1
		 55	[842]	ISF  	   		3	; if not ref_height
		 56	[842]	JMP  	 12		7	; 	goto 64
		 57	[843]	MOV  	 13		0	; slot13 = self
		 58	[843]	TGETS	 12	0	1	; slot12 = self.get_texture_scale
		 59	[843]	MOV  	 14		4	; slot14 = item_name
		 60	[843]	MOV  	 15		3	; slot15 = ref_height
		 61	[843]	MOV  	 16		10	; slot16 = forced_texture_size
		 62	[843]	CALL 	 12	2	5	; slot12 = self.get_texture_scale(self, item_name, ref_height, forced_texture_size)
		 63	[843]	MOV  	 11		12	; slot11 = self.get_texture_scale
		 64	[845]	UGET 	 12		1	; slot12 = uv1"I"
		 65	[845]	MOV  	 13		12	; slot13 = uv1"I"
		 66	[845]	TGETS	 12	12	0	; slot12 = uv1"I".unload_atlas
		 67	[845]	MOV  	 14		9	; slot14 = group
		 68	[845]	MOV  	 15		11	; slot15 = scale
		 69	[845]	CALL 	 12	1	4	;  = uv1"I".unload_atlas(uv1"I", group, scale)
		 70	[822]	ITERN	  8	3	3	; slot8, slot9, slot10 = slot5<generator>, slot6<state>, slot7<control>; slot8, slot9 = slot5<generator>(slot6<state>, slot7<control>)
		 71	[822]	ITERL	  8		-67	; slot7<control> = slot8; if slot8 != nil goto 5
		 72	[847]	RET0 	  0		1	; return
	102	[821]	TSETS	 23	22	58	; director.unload_texture_groups = slot23
	103	[849]	GGET 	 22		99	; slot22 = _env["director"]
	104	[900]	FNEW 	 23		55	; @./all/director.lua:849-900: 6 args, 3 upvalues, 25 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	features
		  1:	log
		  2:	I
		;;;; variable info ;;;;
		  0-105:	self
		  0-105:	groups
		  0-105:	texture_size
		  0-105:	ref_height
		  0-105:	queue
		  0-105:	item_name
		  1-105:	override_ov
		  2-105:	scale
		  5-104:	<generator>
		  5-104:	<state>
		  5-104:	<control>
		  6-102:	_
		  6-102:	group
		  7-102:	texture_path
		  7-102:	forced_texture_size
		  34-66:	<generator>
		  34-66:	<state>
		  34-66:	<control>
		  35-64:	_
		  35-64:	v
		;;;; instructions ;;;;
		  1	[861]	FNEW 	  6		16	; @./all/director.lua:850-861: 2 args, 2 upvalues, 13 slots
			
			;;;; constant tables ;;;;
			;;;; upvalue names ;;;;
			  0:	features
			  1:	log
			;;;; variable info ;;;;
			  0-34:	texture_path
			  0-34:	group
			  8-33:	<generator>
			  8-33:	<state>
			  8-33:	<control>
			  9-31:	_
			  9-31:	n
			  13-31:	ov_path
			;;;; instructions ;;;;
			  1	[851]	UGET 	  2		0	; slot2 = uv0"features"
			  2	[851]	TGETS	  2	2	9	; slot2 = uv0"features".overrides
			  3	[851]	ISF  	   		2	; if not uv0"features".overrides
			  4	[851]	JMP  	  3		29	; 	goto 34
			  5	[852]	GGET 	  2		8	; slot2 = _env["pairs"]
			  6	[852]	UGET 	  3		0	; slot3 = uv0"features"
			  7	[852]	TGETS	  3	3	9	; slot3 = uv0"features".overrides
			  8	[852]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(uv0"features".overrides)
			  9	[852]	ISNEXT	  5		22	; Verify ITERN at 32; goto 32
			 10	[853]	MOV  	  7		0	; slot7 = texture_path
			 11	[853]	KSTR 	  8		7	; slot8 = "/_ov/"
			 12	[853]	MOV  	  9		6	; slot9 = n
			 13	[853]	CAT  	  7	7	9	; slot7 = texture_path .. slot8 .. n
			 14	[854]	GGET 	  8		6	; slot8 = _env["love"]
			 15	[854]	TGETS	  8	8	5	; slot8 = love.filesystem
			 16	[854]	TGETS	  8	8	4	; slot8 = love.filesystem.exists
			 17	[854]	MOV  	  9		7	; slot9 = ov_path
			 18	[854]	KSTR 	 10		3	; slot10 = "/"
			 19	[854]	MOV  	 11		1	; slot11 = group
			 20	[854]	KSTR 	 12		2	; slot12 = ".lua"
			 21	[854]	CAT  	  9	9	12	; slot9 = ov_path .. slot10 .. group .. slot12
			 22	[854]	CALL 	  8	2	2	; slot8 = love.filesystem.exists(slot9)
			 23	[854]	ISF  	   		8	; if not love.filesystem.exists
			 24	[854]	JMP  	  9		7	; 	goto 32
			 25	[855]	UGET 	  8		1	; slot8 = uv1"log"
			 26	[855]	TGETS	  8	8	1	; slot8 = uv1"log".debug
			 27	[855]	KSTR 	  9		0	; slot9 = "  +++ texture group %s overriden by %s"
			 28	[855]	MOV  	 10		1	; slot10 = group
			 29	[855]	MOV  	 11		6	; slot11 = n
			 30	[855]	CALL 	  8	1	4	;  = uv1"log".debug(slot9, group, n)
			 31	[856]	MOV  	  0		7	; slot0 = ov_path
			 32	[852]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
			 33	[852]	ITERL	  5		-24	; slot4<control> = slot5; if slot5 != nil goto 10
			 34	[860]	RET1 	  0		2	; return texture_path
		  2	[862]	KSHORT	  7		1	; slot7 = 1
		  3	[863]	GGET 	  8		15	; slot8 = _env["pairs"]
		  4	[863]	MOV  	  9		1	; slot9 = groups
		  5	[863]	CALL 	  8	4	2	; slot8, slot9, slot10 = pairs(groups)
		  6	[863]	ISNEXT	 11		96	; Verify ITERN at 103; goto 103
		  7	[864]	KNIL 	 13		14	; slot13, slot14 = nil
		  8	[866]	GGET 	 15		14	; slot15 = _env["KR_PATH_ASSETS_GAME_FALLBACK"]
		  9	[866]	ISF  	   		15	; if not KR_PATH_ASSETS_GAME_FALLBACK
		 10	[866]	JMP  	 16		57	; 	goto 68
		 11	[869]	GGET 	 15		13	; slot15 = _env["KR_PATH_ASSETS_GAME_TARGET"]
		 12	[869]	KSTR 	 16		12	; slot16 = "/images/"
		 13	[869]	MOV  	 17		2	; slot17 = texture_size
		 14	[869]	CAT  	 13	15	17	; slot13 = KR_PATH_ASSETS_GAME_TARGET .. slot16 .. texture_size
		 15	[870]	MOV  	 15		6	; slot15 = override_ov
		 16	[870]	MOV  	 16		13	; slot16 = texture_path
		 17	[870]	MOV  	 17		12	; slot17 = group
		 18	[870]	CALL 	 15	2	3	; slot15 = override_ov(texture_path, group)
		 19	[870]	MOV  	 13		15	; slot13 = override_ov
		 20	[871]	GGET 	 15		11	; slot15 = _env["love"]
		 21	[871]	TGETS	 15	15	10	; slot15 = love.filesystem
		 22	[871]	TGETS	 15	15	9	; slot15 = love.filesystem.exists
		 23	[871]	MOV  	 16		13	; slot16 = texture_path
		 24	[871]	KSTR 	 17		8	; slot17 = "/"
		 25	[871]	MOV  	 18		12	; slot18 = group
		 26	[871]	KSTR 	 19		7	; slot19 = ".lua"
		 27	[871]	CAT  	 16	16	19	; slot16 = texture_path .. slot17 .. group .. slot19
		 28	[871]	CALL 	 15	2	2	; slot15 = love.filesystem.exists(slot16)
		 29	[871]	ISF  	   		15	; if not love.filesystem.exists
		 30	[871]	JMP  	 16		1	; 	goto 32
		 31	[872]	JMP  	 15		45	; 	goto 77
		 32	[874]	GGET 	 15		15	; slot15 = _env["pairs"]
		 33	[874]	GGET 	 16		14	; slot16 = _env["KR_PATH_ASSETS_GAME_FALLBACK"]
		 34	[874]	CALL 	 15	4	2	; slot15, slot16, slot17 = pairs(KR_PATH_ASSETS_GAME_FALLBACK)
		 35	[874]	ISNEXT	 18		29	; Verify ITERN at 65; goto 65
		 36	[875]	TGETS	 20	19	6	; slot20 = v.path
		 37	[875]	KSTR 	 21		12	; slot21 = "/images/"
		 38	[875]	TGETS	 22	19	5	; slot22 = v.texture_size
		 39	[875]	CAT  	 13	20	22	; slot13 = v.path .. slot21 .. v.texture_size
		 40	[876]	MOV  	 20		6	; slot20 = override_ov
		 41	[876]	MOV  	 21		13	; slot21 = texture_path
		 42	[876]	MOV  	 22		12	; slot22 = group
		 43	[876]	CALL 	 20	2	3	; slot20 = override_ov(texture_path, group)
		 44	[876]	MOV  	 13		20	; slot13 = override_ov
		 45	[877]	GGET 	 20		11	; slot20 = _env["love"]
		 46	[877]	TGETS	 20	20	10	; slot20 = love.filesystem
		 47	[877]	TGETS	 20	20	9	; slot20 = love.filesystem.exists
		 48	[877]	MOV  	 21		13	; slot21 = texture_path
		 49	[877]	KSTR 	 22		8	; slot22 = "/"
		 50	[877]	MOV  	 23		12	; slot23 = group
		 51	[877]	KSTR 	 24		7	; slot24 = ".lua"
		 52	[877]	CAT  	 21	21	24	; slot21 = texture_path .. slot22 .. group .. slot24
		 53	[877]	CALL 	 20	2	2	; slot20 = love.filesystem.exists(slot21)
		 54	[877]	ISF  	   		20	; if not love.filesystem.exists
		 55	[877]	JMP  	 21		9	; 	goto 65
		 56	[878]	UGET 	 20		1	; slot20 = uv1"log"
		 57	[878]	TGETS	 20	20	4	; slot20 = uv1"log".debug
		 58	[878]	KSTR 	 21		3	; slot21 = "  +++ texture group %s fallback to %s (size:%s)"
		 59	[878]	MOV  	 22		12	; slot22 = group
		 60	[878]	MOV  	 23		13	; slot23 = texture_path
		 61	[878]	TGETS	 24	19	5	; slot24 = v.texture_size
		 62	[878]	CALL 	 20	1	5	;  = uv1"log".debug(slot21, group, texture_path, v.texture_size)
		 63	[879]	TGETS	 14	19	5	; slot14 = v.texture_size
		 64	[880]	JMP  	 15		12	; 	goto 77
		 65	[874]	ITERN	 18	3	3	; slot18, slot19, slot20 = slot15<generator>, slot16<state>, slot17<control>; slot18, slot19 = slot15<generator>(slot16<state>, slot17<control>)
		 66	[874]	ITERL	 18		-31	; slot17<control> = slot18; if slot18 != nil goto 36
		 67	[883]	JMP  	 15		9	; 	goto 77
		 68	[885]	GGET 	 15		13	; slot15 = _env["KR_PATH_ASSETS_GAME_TARGET"]
		 69	[885]	KSTR 	 16		12	; slot16 = "/images/"
		 70	[885]	MOV  	 17		2	; slot17 = texture_size
		 71	[885]	CAT  	 13	15	17	; slot13 = KR_PATH_ASSETS_GAME_TARGET .. slot16 .. texture_size
		 72	[886]	MOV  	 15		6	; slot15 = override_ov
		 73	[886]	MOV  	 16		13	; slot16 = texture_path
		 74	[886]	MOV  	 17		12	; slot17 = group
		 75	[886]	CALL 	 15	2	3	; slot15 = override_ov(texture_path, group)
		 76	[886]	MOV  	 13		15	; slot13 = override_ov
		 77	[890]	ISF  	   		3	; if not ref_height
		 78	[890]	JMP  	 15		7	; 	goto 86
		 79	[891]	MOV  	 16		0	; slot16 = self
		 80	[891]	TGETS	 15	0	2	; slot15 = self.get_texture_scale
		 81	[891]	MOV  	 17		5	; slot17 = item_name
		 82	[891]	MOV  	 18		3	; slot18 = ref_height
		 83	[891]	MOV  	 19		14	; slot19 = forced_texture_size
		 84	[891]	CALL 	 15	2	5	; slot15 = self.get_texture_scale(self, item_name, ref_height, forced_texture_size)
		 85	[891]	MOV  	  7		15	; slot7 = self.get_texture_scale
		 86	[894]	ISF  	   		4	; if not queue
		 87	[894]	JMP  	 15		8	; 	goto 96
		 88	[895]	UGET 	 15		2	; slot15 = uv2"I"
		 89	[895]	MOV  	 16		15	; slot16 = uv2"I"
		 90	[895]	TGETS	 15	15	1	; slot15 = uv2"I".queue_load_atlas
		 91	[895]	MOV  	 17		7	; slot17 = scale
		 92	[895]	MOV  	 18		13	; slot18 = texture_path
		 93	[895]	MOV  	 19		12	; slot19 = group
		 94	[895]	CALL 	 15	1	5	;  = uv2"I".queue_load_atlas(uv2"I", scale, texture_path, group)
		 95	[895]	JMP  	 15		7	; 	goto 103
		 96	[897]	UGET 	 15		2	; slot15 = uv2"I"
		 97	[897]	MOV  	 16		15	; slot16 = uv2"I"
		 98	[897]	TGETS	 15	15	0	; slot15 = uv2"I".load_atlas
		 99	[897]	MOV  	 17		7	; slot17 = scale
		100	[897]	MOV  	 18		13	; slot18 = texture_path
		101	[897]	MOV  	 19		12	; slot19 = group
		102	[897]	CALL 	 15	1	5	;  = uv2"I".load_atlas(uv2"I", scale, texture_path, group)
		103	[863]	ITERN	 11	3	3	; slot11, slot12, slot13 = slot8<generator>, slot9<state>, slot10<control>; slot11, slot12 = slot8<generator>(slot9<state>, slot10<control>)
		104	[863]	ITERL	 11		-98	; slot10<control> = slot11; if slot11 != nil goto 7
		105	[900]	RET0 	  0		1	; return
	105	[849]	TSETS	 23	22	56	; director.load_texture_groups = slot23
	106	[902]	GGET 	 22		99	; slot22 = _env["director"]
	107	[910]	FNEW 	 23		53	; @./all/director.lua:902-910: 2 args, 1 upvalues, 10 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	S
		;;;; variable info ;;;;
		  0-18:	self
		  0-18:	groups
		  9-17:	<generator>
		  9-17:	<state>
		  9-17:	<control>
		  10-15:	_
		  10-15:	group
		;;;; instructions ;;;;
		  1	[903]	UGET 	  2		0	; slot2 = uv0"S"
		  2	[903]	TGETS	  3	0	3	; slot3 = self.params
		  3	[903]	TGETS	  3	3	2	; slot3 = self.params.audio_mode
		  4	[903]	TSETS	  3	2	4	; uv0"S".global_source_mode = self.params.audio_mode
		  5	[904]	ISF  	   		1	; if not groups
		  6	[904]	JMP  	  2		11	; 	goto 18
		  7	[905]	GGET 	  2		1	; slot2 = _env["pairs"]
		  8	[905]	MOV  	  3		1	; slot3 = groups
		  9	[905]	CALL 	  2	4	2	; slot2, slot3, slot4 = pairs(groups)
		 10	[905]	ISNEXT	  5		5	; Verify ITERN at 16; goto 16
		 11	[907]	UGET 	  7		0	; slot7 = uv0"S"
		 12	[907]	MOV  	  8		7	; slot8 = uv0"S"
		 13	[907]	TGETS	  7	7	0	; slot7 = uv0"S".queue_load_group
		 14	[907]	MOV  	  9		6	; slot9 = group
		 15	[907]	CALL 	  7	1	3	;  = uv0"S".queue_load_group(uv0"S", group)
		 16	[905]	ITERN	  5	3	3	; slot5, slot6, slot7 = slot2<generator>, slot3<state>, slot4<control>; slot5, slot6 = slot2<generator>(slot3<state>, slot4<control>)
		 17	[905]	ITERL	  5		-7	; slot4<control> = slot5; if slot5 != nil goto 11
		 18	[910]	RET0 	  0		1	; return
	108	[902]	TSETS	 23	22	54	; director.load_sound_groups = slot23
	109	[912]	GGET 	 22		99	; slot22 = _env["director"]
	110	[915]	FNEW 	 23		51	; @./all/director.lua:912-915: 2 args, 2 upvalues, 4 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	I
		  1:	S
		;;;; variable info ;;;;
		  0-11:	self
		  0-11:	dt
		;;;; instructions ;;;;
		  1	[914]	UGET 	  2		0	; slot2 = uv0"I"
		  2	[914]	MOV  	  3		2	; slot3 = uv0"I"
		  3	[914]	TGETS	  2	2	0	; slot2 = uv0"I".queue_load_done
		  4	[914]	CALL 	  2	2	2	; slot2 = uv0"I".queue_load_done(uv0"I")
		  5	[914]	ISF  	   		2	; if not slot2
		  6	[914]	JMP  	  3		4	; 	goto 11
		  7	[914]	UGET 	  2		1	; slot2 = uv1"S"
		  8	[914]	MOV  	  3		2	; slot3 = uv1"S"
		  9	[914]	TGETS	  2	2	0	; slot2 = uv1"S".queue_load_done
		 10	[914]	CALL 	  2	2	2	; slot2 = uv1"S".queue_load_done(uv1"S")
		 11	[914]	RET1 	  2		2	; return slot2
	111	[912]	TSETS	 23	22	52	; director.queued_item_ready = slot23
	112	[920]	GGET 	 22		99	; slot22 = _env["director"]
	113	[1021]	FNEW 	 23		49	; @./all/director.lua:920-1021: 2 args, 5 upvalues, 12 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	S
		  1:	signal
		  2:	log
		  3:	ISM
		  4:	services
		;;;; variable info ;;;;
		  0-221:	self
		  0-221:	dt
		  27-31:	ai
		  32-221:	ai
		  41-221:	aits
		  69-194:	ai
		  79-103:	item
		  80-103:	cb
		  180-194:	item
		  181-194:	fps
		  208-214:	state
		;;;; instructions ;;;;
		  1	[922]	UGET 	  2		0	; slot2 = uv0"S"
		  2	[922]	MOV  	  3		2	; slot3 = uv0"S"
		  3	[922]	TGETS	  2	2	43	; slot2 = uv0"S".update
		  4	[922]	MOV  	  4		1	; slot4 = dt
		  5	[922]	CALL 	  2	1	3	;  = uv0"S".update(uv0"S", dt)
		  6	[925]	TGETS	  2	0	42	; slot2 = self.next_item_name
		  7	[925]	ISF  	   		2	; if not self.next_item_name
		  8	[925]	JMP  	  3		15	; 	goto 24
		  9	[926]	MOV  	  3		0	; slot3 = self
		 10	[926]	TGETS	  2	0	41	; slot2 = self.queue_load_item_named
		 11	[926]	TGETS	  4	0	42	; slot4 = self.next_item_name
		 12	[926]	TGETS	  5	0	40	; slot5 = self.force_reload
		 13	[926]	CALL 	  2	1	4	;  = self.queue_load_item_named(self, self.next_item_name, self.force_reload)
		 14	[927]	KPRI 	  2		1	; slot2 = false
		 15	[927]	TSETS	  2	0	39	; self.queued_item_init = slot2
		 16	[928]	KPRI 	  2		1	; slot2 = false
		 17	[928]	TSETS	  2	0	38	; self.queued_item_first_draw = slot2
		 18	[929]	TGETS	  2	0	42	; slot2 = self.next_item_name
		 19	[929]	TSETS	  2	0	37	; self.last_item_name = self.next_item_name
		 20	[930]	KPRI 	  2		0	; slot2 = nil
		 21	[930]	TSETS	  2	0	42	; self.next_item_name = slot2
		 22	[931]	KPRI 	  2		0	; slot2 = nil
		 23	[931]	TSETS	  2	0	40	; self.force_reload = slot2
		 24	[935]	TGETS	  2	0	36	; slot2 = self.active_item
		 25	[935]	ISF  	   		2	; if not self.active_item
		 26	[935]	JMP  	  3		5	; 	goto 32
		 27	[936]	TGETS	  2	0	36	; slot2 = self.active_item
		 28	[937]	MOV  	  4		2	; slot4 = ai
		 29	[937]	TGETS	  3	2	43	; slot3 = ai.update
		 30	[937]	MOV  	  5		1	; slot5 = dt
		 31	[937]	CALL 	  3	1	3	;  = ai.update(ai, dt)
		 32	[941]	TGETS	  2	0	36	; slot2 = self.active_item
		 33	[942]	ISF  	   		2	; if not ai
		 34	[942]	JMP  	  3		6	; 	goto 41
		 35	[942]	TGETS	  3	2	35	; slot3 = ai.is_transition
		 36	[942]	ISF  	   		3	; if not ai.is_transition
		 37	[942]	JMP  	  4		3	; 	goto 41
		 38	[942]	TGETS	  3	2	34	; slot3 = ai.transition_state
		 39	[942]	IST  	   		3	; if ai.transition_state
		 40	[942]	JMP  	  4		1	; 	goto 42
		 41	[942]	KPRI 	  3		0	; slot3 = nil
		 42	[943]	ISEQS	  3		33	; if aits == "closing"
		 43	[943]	JMP  	  4		151	; 	goto 195
		 44	[943]	ISNES	  3		32	; if aits ~= "opening"
		 45	[943]	JMP  	  4		1	; 	goto 47
		 46	[944]	JMP  	  4		148	; 	goto 195
		 47	[948]	TGETS	  4	0	31	; slot4 = self.queue_unload_item
		 48	[948]	ISF  	   		4	; if not self.queue_unload_item
		 49	[948]	JMP  	  5		10	; 	goto 60
		 50	[948]	ISF  	   		3	; if not aits
		 51	[948]	JMP  	  4		2	; 	goto 54
		 52	[948]	ISNES	  3		30	; if aits ~= "closed"
		 53	[948]	JMP  	  4		6	; 	goto 60
		 54	[949]	MOV  	  5		0	; slot5 = self
		 55	[949]	TGETS	  4	0	29	; slot4 = self.unload_item
		 56	[949]	TGETS	  6	0	31	; slot6 = self.queue_unload_item
		 57	[949]	CALL 	  4	1	3	;  = self.unload_item(self, self.queue_unload_item)
		 58	[950]	KPRI 	  4		0	; slot4 = nil
		 59	[950]	TSETS	  4	0	31	; self.queue_unload_item = slot4
		 60	[954]	TGETS	  4	0	28	; slot4 = self.queued_item
		 61	[954]	ISF  	   		4	; if not self.queued_item
		 62	[954]	JMP  	  5		132	; 	goto 195
		 63	[954]	MOV  	  5		0	; slot5 = self
		 64	[954]	TGETS	  4	0	27	; slot4 = self.queued_item_ready
		 65	[954]	MOV  	  6		1	; slot6 = dt
		 66	[954]	CALL 	  4	2	3	; slot4 = self.queued_item_ready(self, dt)
		 67	[954]	ISF  	   		4	; if not self.queued_item_ready
		 68	[954]	JMP  	  5		126	; 	goto 195
		 69	[955]	TGETS	  4	0	36	; slot4 = self.active_item
		 70	[958]	ISF  	   		4	; if not ai
		 71	[958]	JMP  	  5		4	; 	goto 76
		 72	[958]	TGETS	  5	4	26	; slot5 = ai.hold_enabled
		 73	[958]	ISF  	   		5	; if not ai.hold_enabled
		 74	[958]	JMP  	  6		1	; 	goto 76
		 75	[959]	JMP  	  4		119	; 	goto 195
		 76	[963]	TGETS	  5	0	39	; slot5 = self.queued_item_init
		 77	[963]	IST  	   		5	; if self.queued_item_init
		 78	[963]	JMP  	  5		26	; 	goto 105
		 79	[964]	TGETS	  5	0	28	; slot5 = self.queued_item
		 80	[965]	FNEW 	  6		25	; @./all/director.lua:965-965: 1 args, 2 upvalues, 5 slots
			
			;;;; constant tables ;;;;
			;;;; instructions ;;;;
			  1	[965]	UGET 	  1		0	; slot1 = uv0"self"
			  2	[965]	MOV  	  2		1	; slot2 = uv0"self"
			  3	[965]	TGETS	  1	1	1	; slot1 = uv0"self".item_done_callback
			  4	[965]	UGET 	  3		1	; slot3 = uv1"item"
			  5	[965]	TGETS	  3	3	0	; slot3 = uv1"item".item_name
			  6	[965]	MOV  	  4		0	; slot4 = outcome
			  7	[965]	CALL 	  1	1	4	;  = uv0"self".item_done_callback(uv0"self", uv1"item".item_name, outcome)
			  8	[965]	RET0 	  0		1	; return
		 81	[966]	TGETS	  7	0	28	; slot7 = self.queued_item
		 82	[966]	MOV  	  8		7	; slot8 = self.queued_item
		 83	[966]	TGETS	  7	7	24	; slot7 = self.queued_item.init
		 84	[966]	TGETS	  9	0	23	; slot9 = self.params
		 85	[966]	TGETS	  9	9	22	; slot9 = self.params.width
		 86	[966]	TGETS	 10	0	23	; slot10 = self.params
		 87	[966]	TGETS	 10	10	21	; slot10 = self.params.height
		 88	[966]	MOV  	 11		6	; slot11 = cb
		 89	[966]	CALL 	  7	1	5	;  = self.queued_item.init(self.queued_item, self.params.width, self.params.height, cb)
		 90	[967]	TGETS	  7	0	28	; slot7 = self.queued_item
		 91	[967]	KPRI 	  8		0	; slot8 = nil
		 92	[967]	TSETS	  8	7	20	; self.queued_item.done_callback_called = slot8
		 93	[968]	KPRI 	  7		2	; slot7 = true
		 94	[968]	TSETS	  7	0	39	; self.queued_item_init = slot7
		 95	[969]	KPRI 	  7		1	; slot7 = false
		 96	[969]	TSETS	  7	0	38	; self.queued_item_first_draw = slot7
		 97	[970]	TGETS	  7	0	28	; slot7 = self.queued_item
		 98	[970]	MOV  	  8		7	; slot8 = self.queued_item
		 99	[970]	TGETS	  7	7	43	; slot7 = self.queued_item.update
		100	[970]	GGET 	  9		19	; slot9 = _env["TICK_LENGTH"]
		101	[970]	MULNV	  9	9	0	; slot9 = 2 * TICK_LENGTH
		102	[970]	CALL 	  7	1	3	;  = self.queued_item.update(self.queued_item, slot9)
		103	[971]	UCLO 	  4		91	; nil uvs >= r4; goto 195
		104	[971]	UCLO 	  5		0	; nil uvs >= r5; goto 105
		105	[975]	ISF  	   		4	; if not ai
		106	[975]	JMP  	  5		20	; 	goto 127
		107	[976]	TGETS	  5	4	34	; slot5 = ai.transition_state
		108	[976]	ISNES	  5		33	; if ai.transition_state ~= "closing"
		109	[976]	JMP  	  5		2	; 	goto 112
		110	[977]	JMP  	  4		84	; 	goto 195
		111	[977]	JMP  	  5		15	; 	goto 127
		112	[978]	TGETS	  5	4	34	; slot5 = ai.transition_state
		113	[978]	ISNES	  5		30	; if ai.transition_state ~= "closed"
		114	[978]	JMP  	  5		8	; 	goto 123
		115	[978]	TGETS	  5	0	38	; slot5 = self.queued_item_first_draw
		116	[978]	ISF  	   		5	; if not self.queued_item_first_draw
		117	[978]	JMP  	  6		5	; 	goto 123
		118	[979]	MOV  	  6		4	; slot6 = ai
		119	[979]	TGETS	  5	4	18	; slot5 = ai.open
		120	[979]	CALL 	  5	1	2	;  = ai.open(ai)
		121	[980]	JMP  	  4		73	; 	goto 195
		122	[980]	JMP  	  5		4	; 	goto 127
		123	[981]	TGETS	  5	4	34	; slot5 = ai.transition_state
		124	[981]	ISNES	  5		32	; if ai.transition_state ~= "opening"
		125	[981]	JMP  	  5		1	; 	goto 127
		126	[982]	JMP  	  4		68	; 	goto 195
		127	[987]	MOV  	  6		0	; slot6 = self
		128	[987]	TGETS	  5	0	29	; slot5 = self.unload_item
		129	[987]	TGETS	  7	0	36	; slot7 = self.active_item
		130	[987]	TGETS	  8	0	17	; slot8 = self.next_item_args
		131	[987]	ISF  	   		8	; if not self.next_item_args
		132	[987]	JMP  	  9		2	; 	goto 135
		133	[987]	TGETS	  8	0	17	; slot8 = self.next_item_args
		134	[987]	TGETS	  8	8	16	; slot8 = self.next_item_args.postpone_unload
		135	[987]	CALL 	  5	1	4	;  = self.unload_item(self, self.active_item, self.next_item_args.postpone_unload)
		136	[988]	TGETS	  5	0	28	; slot5 = self.queued_item
		137	[988]	TSETS	  5	0	36	; self.active_item = self.queued_item
		138	[989]	KPRI 	  5		0	; slot5 = nil
		139	[989]	TSETS	  5	0	28	; self.queued_item = slot5
		140	[990]	KPRI 	  5		0	; slot5 = nil
		141	[990]	TSETS	  5	0	39	; self.queued_item_init = slot5
		142	[991]	UGET 	  5		1	; slot5 = uv1"signal"
		143	[991]	TGETS	  5	5	15	; slot5 = uv1"signal".emit
		144	[991]	GGET 	  6		14	; slot6 = _env["SGN_DIRECTOR_ITEM_SHOWN"]
		145	[991]	TGETS	  7	0	36	; slot7 = self.active_item
		146	[991]	TGETS	  7	7	13	; slot7 = self.active_item.item_name
		147	[991]	TGETS	  8	0	36	; slot8 = self.active_item
		148	[991]	CALL 	  5	1	4	;  = uv1"signal".emit(SGN_DIRECTOR_ITEM_SHOWN, self.active_item.item_name, self.active_item)
		149	[992]	TGETS	  5	0	36	; slot5 = self.active_item
		150	[992]	TGETS	  5	5	13	; slot5 = self.active_item.item_name
		151	[992]	ISNES	  5		12	; if self.active_item.item_name ~= "comics"
		152	[992]	JMP  	  5		18	; 	goto 171
		153	[992]	TGETS	  5	0	36	; slot5 = self.active_item
		154	[992]	TGETS	  5	5	11	; slot5 = self.active_item.game_item
		155	[992]	ISF  	   		5	; if not self.active_item.game_item
		156	[992]	JMP  	  6		14	; 	goto 171
		157	[993]	UGET 	  5		2	; slot5 = uv2"log"
		158	[993]	TGETS	  5	5	10	; slot5 = uv2"log".start_time
		159	[993]	GGET 	  6		9	; slot6 = _env["string"]
		160	[993]	TGETS	  6	6	8	; slot6 = string.format
		161	[993]	KSTR 	  7		7	; slot7 = "comic/%02i"
		162	[993]	TGETS	  8	0	36	; slot8 = self.active_item
		163	[993]	TGETS	  8	8	6	; slot8 = self.active_item.comic_idx
		164	[993]	IST  	   		8	; if self.active_item.comic_idx
		165	[993]	JMP  	  9		1	; 	goto 167
		166	[993]	KSHORT	  8		0	; slot8 = 0
		167	[993]	CALL 	  6	2	3	; slot6 = string.format(slot7, slot8)
		168	[993]	TGETS	  7	0	5	; slot7 = self.load_ctx
		169	[993]	CALL 	  5	1	3	;  = uv2"log".start_time(string.format, self.load_ctx)
		170	[993]	JMP  	  5		9	; 	goto 180
		171	[994]	TGETS	  5	0	5	; slot5 = self.load_ctx
		172	[994]	ISF  	   		5	; if not self.load_ctx
		173	[994]	JMP  	  6		6	; 	goto 180
		174	[995]	UGET 	  5		2	; slot5 = uv2"log"
		175	[995]	TGETS	  5	5	4	; slot5 = uv2"log".end_time
		176	[995]	TGETS	  6	0	5	; slot6 = self.load_ctx
		177	[995]	CALL 	  5	1	2	;  = uv2"log".end_time(self.load_ctx)
		178	[996]	KPRI 	  5		0	; slot5 = nil
		179	[996]	TSETS	  5	0	5	; self.load_ctx = slot5
		180	[1000]	TGETS	  5	0	36	; slot5 = self.active_item
		181	[1001]	KPRI 	  6		0	; slot6 = nil
		182	[1002]	TGETS	  7	5	3	; slot7 = item.max_fps
		183	[1002]	ISF  	   		7	; if not item.max_fps
		184	[1002]	JMP  	  8		2	; 	goto 187
		185	[1004]	TGETS	  6	5	3	; slot6 = item.max_fps
		186	[1004]	JMP  	  7		7	; 	goto 194
		187	[1007]	TGETS	  7	0	23	; slot7 = self.params
		188	[1007]	TGETS	  7	7	2	; slot7 = self.params.vsync
		189	[1007]	IST  	   		7	; if self.params.vsync
		190	[1007]	JMP  	  7		2	; 	goto 193
		191	[1007]	KSHORT	  6		60	; slot6 = 60
		192	[1007]	JMP  	  7		1	; 	goto 194
		193	[1007]	KPRI 	  6		0	; slot6 = nil
		194	[1009]	TSETS	  6	5	1	; item.limit_fps = fps
		195	[1014]	UGET 	  4		3	; slot4 = uv3"ISM"
		196	[1014]	ISF  	   		4	; if not uv3"ISM"
		197	[1014]	JMP  	  5		17	; 	goto 215
		198	[1015]	TGETS	  4	0	36	; slot4 = self.active_item
		199	[1015]	ISF  	   		4	; if not self.active_item
		200	[1015]	JMP  	  5		8	; 	goto 209
		201	[1015]	TGETS	  4	0	36	; slot4 = self.active_item
		202	[1015]	TGETS	  4	4	0	; slot4 = self.active_item.get_ism_state
		203	[1015]	ISF  	   		4	; if not self.active_item.get_ism_state
		204	[1015]	JMP  	  5		4	; 	goto 209
		205	[1015]	TGETS	  4	0	36	; slot4 = self.active_item
		206	[1015]	MOV  	  5		4	; slot5 = self.active_item
		207	[1015]	TGETS	  4	4	0	; slot4 = self.active_item.get_ism_state
		208	[1015]	CALL 	  4	2	2	; slot4 = self.active_item.get_ism_state(self.active_item)
		209	[1016]	UGET 	  5		3	; slot5 = uv3"ISM"
		210	[1016]	MOV  	  6		5	; slot6 = uv3"ISM"
		211	[1016]	TGETS	  5	5	43	; slot5 = uv3"ISM".update
		212	[1016]	MOV  	  7		1	; slot7 = dt
		213	[1016]	MOV  	  8		4	; slot8 = state
		214	[1016]	CALL 	  5	1	4	;  = uv3"ISM".update(uv3"ISM", dt, state)
		215	[1020]	UGET 	  4		4	; slot4 = uv4"services"
		216	[1020]	MOV  	  5		4	; slot5 = uv4"services"
		217	[1020]	TGETS	  4	4	43	; slot4 = uv4"services".update
		218	[1020]	MOV  	  6		1	; slot6 = dt
		219	[1020]	CALL 	  4	1	3	;  = uv4"services".update(uv4"services", dt)
		220	[1021]	UCLO 	  0		0	; nil uvs >= r0; goto 221
		221	[1021]	RET0 	  0		1	; return
	114	[920]	TSETS	 23	22	50	; director.update = slot23
	115	[1023]	GGET 	 22		99	; slot22 = _env["director"]
	116	[1047]	FNEW 	 23		47	; @./all/director.lua:1023-1047: 1 args, 1 upvalues, 6 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	G
		;;;; variable info ;;;;
		  0-53:	self
		  17-52:	ai
		;;;; instructions ;;;;
		  1	[1024]	TGETS	  1	0	13	; slot1 = self.active_item
		  2	[1024]	ISF  	   		1	; if not self.active_item
		  3	[1024]	JMP  	  2		49	; 	goto 53
		  4	[1025]	TGETS	  1	0	12	; slot1 = self.scissor_w
		  5	[1025]	ISF  	   		1	; if not self.scissor_w
		  6	[1025]	JMP  	  2		10	; 	goto 17
		  7	[1025]	TGETS	  1	0	11	; slot1 = self.scissor_enabled
		  8	[1025]	ISF  	   		1	; if not self.scissor_enabled
		  9	[1025]	JMP  	  2		7	; 	goto 17
		 10	[1026]	UGET 	  1		0	; slot1 = uv0"G"
		 11	[1026]	TGETS	  1	1	10	; slot1 = uv0"G".setScissor
		 12	[1026]	TGETS	  2	0	9	; slot2 = self.scissor_x
		 13	[1026]	TGETS	  3	0	8	; slot3 = self.scissor_y
		 14	[1026]	TGETS	  4	0	12	; slot4 = self.scissor_w
		 15	[1026]	TGETS	  5	0	7	; slot5 = self.scissor_h
		 16	[1026]	CALL 	  1	1	5	;  = uv0"G".setScissor(self.scissor_x, self.scissor_y, self.scissor_w, self.scissor_h)
		 17	[1029]	TGETS	  1	0	13	; slot1 = self.active_item
		 18	[1032]	TGETS	  2	1	6	; slot2 = ai.transition_state
		 19	[1032]	ISNES	  2		5	; if ai.transition_state ~= "closing"
		 20	[1032]	JMP  	  2		8	; 	goto 29
		 21	[1032]	TGETS	  2	0	4	; slot2 = self.queue_unload_item
		 22	[1032]	ISF  	   		2	; if not self.queue_unload_item
		 23	[1032]	JMP  	  3		5	; 	goto 29
		 24	[1034]	TGETS	  2	0	4	; slot2 = self.queue_unload_item
		 25	[1034]	MOV  	  3		2	; slot3 = self.queue_unload_item
		 26	[1034]	TGETS	  2	2	3	; slot2 = self.queue_unload_item.draw
		 27	[1034]	CALL 	  2	1	2	;  = self.queue_unload_item.draw(self.queue_unload_item)
		 28	[1034]	JMP  	  2		12	; 	goto 41
		 29	[1035]	TGETS	  2	0	2	; slot2 = self.queued_item
		 30	[1035]	ISF  	   		2	; if not self.queued_item
		 31	[1035]	JMP  	  3		9	; 	goto 41
		 32	[1035]	TGETS	  2	0	1	; slot2 = self.queued_item_init
		 33	[1035]	ISF  	   		2	; if not self.queued_item_init
		 34	[1035]	JMP  	  3		6	; 	goto 41
		 35	[1037]	TGETS	  2	0	2	; slot2 = self.queued_item
		 36	[1037]	MOV  	  3		2	; slot3 = self.queued_item
		 37	[1037]	TGETS	  2	2	3	; slot2 = self.queued_item.draw
		 38	[1037]	CALL 	  2	1	2	;  = self.queued_item.draw(self.queued_item)
		 39	[1038]	KPRI 	  2		2	; slot2 = true
		 40	[1038]	TSETS	  2	0	0	; self.queued_item_first_draw = slot2
		 41	[1041]	MOV  	  3		1	; slot3 = ai
		 42	[1041]	TGETS	  2	1	3	; slot2 = ai.draw
		 43	[1041]	CALL 	  2	1	2	;  = ai.draw(ai)
		 44	[1043]	TGETS	  2	0	12	; slot2 = self.scissor_w
		 45	[1043]	ISF  	   		2	; if not self.scissor_w
		 46	[1043]	JMP  	  3		6	; 	goto 53
		 47	[1043]	TGETS	  2	0	11	; slot2 = self.scissor_enabled
		 48	[1043]	ISF  	   		2	; if not self.scissor_enabled
		 49	[1043]	JMP  	  3		3	; 	goto 53
		 50	[1044]	UGET 	  2		0	; slot2 = uv0"G"
		 51	[1044]	TGETS	  2	2	10	; slot2 = uv0"G".setScissor
		 52	[1044]	CALL 	  2	1	1	;  = uv0"G".setScissor()
		 53	[1047]	RET0 	  0		1	; return
	117	[1023]	TSETS	 23	22	48	; director.draw = slot23
	118	[1049]	GGET 	 22		99	; slot22 = _env["director"]
	119	[1064]	FNEW 	 23		45	; @./all/director.lua:1049-1064: 3 args, 1 upvalues, 11 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	km
		;;;; variable info ;;;;
		  0-30:	self
		  0-30:	start_ts
		  0-30:	sleep_delay
		  4-29:	ai
		  9-29:	limit_interval
		  11-29:	next_frame_ts
		  15-29:	current_ts
		  24-29:	interval
		;;;; instructions ;;;;
		  1	[1050]	TGETS	  3	0	6	; slot3 = self.active_item
		  2	[1050]	ISF  	   		3	; if not self.active_item
		  3	[1050]	JMP  	  4		26	; 	goto 30
		  4	[1051]	TGETS	  3	0	6	; slot3 = self.active_item
		  5	[1053]	TGETS	  4	3	5	; slot4 = ai.limit_fps
		  6	[1053]	ISF  	   		4	; if not ai.limit_fps
		  7	[1053]	JMP  	  5		22	; 	goto 30
		  8	[1054]	TGETS	  4	3	5	; slot4 = ai.limit_fps
		  9	[1054]	DIVNV	  4	4	0	; slot4 = 1 / ai.limit_fps
		 10	[1055]	ADDVV	  5	1	4	; slot5 = start_ts + limit_interval
		 11	[1055]	SUBVV	  5	5	2	; slot5 = slot5 - sleep_delay
		 12	[1056]	GGET 	  6		4	; slot6 = _env["love"]
		 13	[1056]	TGETS	  6	6	3	; slot6 = love.timer
		 14	[1056]	TGETS	  6	6	2	; slot6 = love.timer.getTime
		 15	[1056]	CALL 	  6	2	1	; slot6 = love.timer.getTime()
		 16	[1057]	ISGT 	  5		6	; if next_frame_ts > current_ts
		 17	[1057]	JMP  	  7		1	; 	goto 19
		 18	[1058]	RET0 	  0		1	; return
		 19	[1060]	UGET 	  7		0	; slot7 = uv0"km"
		 20	[1060]	TGETS	  7	7	1	; slot7 = uv0"km".clamp
		 21	[1060]	KSHORT	  8		0	; slot8 = 0
		 22	[1060]	MOV  	  9		4	; slot9 = limit_interval
		 23	[1060]	SUBVV	 10	5	6	; slot10 = next_frame_ts - current_ts
		 24	[1060]	CALL 	  7	2	4	; slot7 = uv0"km".clamp(slot8, limit_interval, slot10)
		 25	[1061]	GGET 	  8		4	; slot8 = _env["love"]
		 26	[1061]	TGETS	  8	8	3	; slot8 = love.timer
		 27	[1061]	TGETS	  8	8	0	; slot8 = love.timer.sleep
		 28	[1061]	MOV  	  9		7	; slot9 = interval
		 29	[1061]	CALL 	  8	1	2	;  = love.timer.sleep(interval)
		 30	[1064]	RET0 	  0		1	; return
	120	[1049]	TSETS	 23	22	46	; director.limit_fps = slot23
	121	[1066]	GGET 	 22		99	; slot22 = _env["director"]
	122	[1115]	FNEW 	 23		43	; @./all/director.lua:1066-1115: 3 args, 3 upvalues, 9 slots
		
		;;;; constant tables ;;;;
		ktable#10 = [
			]
		
		
		;;;; upvalue names ;;;;
		  0:	ISM
		  1:	RC
		  2:	log
		;;;; variable info ;;;;
		  0-149:	self
		  0-149:	key
		  0-149:	isrepeat
		  141-148:	state
		;;;; instructions ;;;;
		  1	[1067]	UGET 	  3		0	; slot3 = uv0"ISM"
		  2	[1067]	ISF  	   		3	; if not uv0"ISM"
		  3	[1067]	JMP  	  4		5	; 	goto 9
		  4	[1067]	UGET 	  3		0	; slot3 = uv0"ISM"
		  5	[1067]	MOV  	  4		3	; slot4 = uv0"ISM"
		  6	[1067]	TGETS	  3	3	37	; slot3 = uv0"ISM".set_last_input
		  7	[1067]	GGET 	  5		36	; slot5 = _env["I_KEYBOARD"]
		  8	[1067]	CALL 	  3	1	3	;  = uv0"ISM".set_last_input(uv0"ISM", I_KEYBOARD)
		  9	[1070]	ISNES	  1		35	; if key ~= "tab"
		 10	[1070]	JMP  	  3		31	; 	goto 42
		 11	[1071]	GGET 	  3		34	; slot3 = _env["love"]
		 12	[1071]	TGETS	  3	3	33	; slot3 = love.window
		 13	[1071]	TGETS	  3	3	32	; slot3 = love.window.getFullscreen
		 14	[1071]	CALL 	  3	2	1	; slot3 = love.window.getFullscreen()
		 15	[1071]	ISF  	   		3	; if not love.window.getFullscreen
		 16	[1071]	JMP  	  4		25	; 	goto 42
		 17	[1072]	GGET 	  3		34	; slot3 = _env["love"]
		 18	[1072]	TGETS	  3	3	31	; slot3 = love.system
		 19	[1072]	TGETS	  3	3	30	; slot3 = love.system.getOS
		 20	[1072]	CALL 	  3	2	1	; slot3 = love.system.getOS()
		 21	[1072]	ISNES	  3		29	; if love.system.getOS ~= "OS X"
		 22	[1072]	JMP  	  3		19	; 	goto 42
		 23	[1073]	GGET 	  3		34	; slot3 = _env["love"]
		 24	[1073]	TGETS	  3	3	28	; slot3 = love.keyboard
		 25	[1073]	TGETS	  3	3	27	; slot3 = love.keyboard.isDown
		 26	[1073]	KSTR 	  4		26	; slot4 = "lgui"
		 27	[1073]	CALL 	  3	2	2	; slot3 = love.keyboard.isDown(slot4)
		 28	[1073]	IST  	   		3	; if love.keyboard.isDown
		 29	[1073]	JMP  	  4		7	; 	goto 37
		 30	[1073]	GGET 	  3		34	; slot3 = _env["love"]
		 31	[1073]	TGETS	  3	3	28	; slot3 = love.keyboard
		 32	[1073]	TGETS	  3	3	27	; slot3 = love.keyboard.isDown
		 33	[1073]	KSTR 	  4		25	; slot4 = "rgui"
		 34	[1073]	CALL 	  3	2	2	; slot3 = love.keyboard.isDown(slot4)
		 35	[1073]	ISF  	   		3	; if not love.keyboard.isDown
		 36	[1073]	JMP  	  4		5	; 	goto 42
		 37	[1075]	GGET 	  3		34	; slot3 = _env["love"]
		 38	[1075]	TGETS	  3	3	33	; slot3 = love.window
		 39	[1075]	TGETS	  3	3	24	; slot3 = love.window.minimize
		 40	[1075]	CALL 	  3	1	1	;  = love.window.minimize()
		 41	[1076]	RET0 	  0		1	; return
		 42	[1080]	GGET 	  3		23	; slot3 = _env["DEBUG"]
		 43	[1080]	ISF  	   		3	; if not DEBUG
		 44	[1080]	JMP  	  4		67	; 	goto 112
		 45	[1081]	ISNES	  1		22	; if key ~= "r"
		 46	[1081]	JMP  	  3		65	; 	goto 112
		 47	[1081]	GGET 	  3		34	; slot3 = _env["love"]
		 48	[1081]	TGETS	  3	3	28	; slot3 = love.keyboard
		 49	[1081]	TGETS	  3	3	27	; slot3 = love.keyboard.isDown
		 50	[1081]	KSTR 	  4		21	; slot4 = "lshift"
		 51	[1081]	CALL 	  3	2	2	; slot3 = love.keyboard.isDown(slot4)
		 52	[1081]	ISF  	   		3	; if not love.keyboard.isDown
		 53	[1081]	JMP  	  4		58	; 	goto 112
		 54	[1081]	IST  	   		2	; if isrepeat
		 55	[1081]	JMP  	  3		56	; 	goto 112
		 56	[1082]	UGET 	  3		1	; slot3 = uv1"RC"
		 57	[1082]	MOV  	  4		3	; slot4 = uv1"RC"
		 58	[1082]	TGETS	  3	3	20	; slot3 = uv1"RC".reload
		 59	[1082]	CALL 	  3	1	2	;  = uv1"RC".reload(uv1"RC")
		 60	[1083]	TGETS	  3	0	19	; slot3 = self.active_item
		 61	[1083]	ISF  	   		3	; if not self.active_item
		 62	[1083]	JMP  	  4		39	; 	goto 102
		 63	[1083]	TGETS	  3	0	19	; slot3 = self.active_item
		 64	[1083]	TGETS	  3	3	18	; slot3 = self.active_item.item_name
		 65	[1083]	ISNES	  3		17	; if self.active_item.item_name ~= "game"
		 66	[1083]	JMP  	  3		35	; 	goto 102
		 67	[1084]	GGET 	  3		34	; slot3 = _env["love"]
		 68	[1084]	TGETS	  3	3	28	; slot3 = love.keyboard
		 69	[1084]	TGETS	  3	3	27	; slot3 = love.keyboard.isDown
		 70	[1084]	KSTR 	  4		16	; slot4 = "lctrl"
		 71	[1084]	CALL 	  3	2	2	; slot3 = love.keyboard.isDown(slot4)
		 72	[1084]	ISF  	   		3	; if not love.keyboard.isDown
		 73	[1084]	JMP  	  4		19	; 	goto 93
		 74	[1085]	KSTR 	  3		17	; slot3 = "game"
		 75	[1085]	TSETS	  3	0	15	; self.next_item_name = slot3
		 76	[1086]	KPRI 	  3		2	; slot3 = true
		 77	[1086]	TSETS	  3	0	14	; self.force_reload = slot3
		 78	[1087]	TDUP 	  3		10	; slot3 = copy table#k10
		 79	[1088]	GGET 	  4		17	; slot4 = _env["game"]
		 80	[1088]	TGETS	  4	4	12	; slot4 = game.store
		 81	[1088]	TGETS	  4	4	11	; slot4 = game.store.level_idx
		 82	[1088]	TSETS	  4	3	11	; slot3.level_idx = game.store.level_idx
		 83	[1089]	GGET 	  4		17	; slot4 = _env["game"]
		 84	[1089]	TGETS	  4	4	12	; slot4 = game.store
		 85	[1089]	TGETS	  4	4	9	; slot4 = game.store.level_mode
		 86	[1089]	TSETS	  4	3	9	; slot3.level_mode = game.store.level_mode
		 87	[1090]	GGET 	  4		17	; slot4 = _env["game"]
		 88	[1090]	TGETS	  4	4	12	; slot4 = game.store
		 89	[1090]	TGETS	  4	4	8	; slot4 = game.store.level_difficulty
		 90	[1090]	TSETS	  4	3	8	; slot3.level_difficulty = game.store.level_difficulty
		 91	[1091]	TSETS	  3	0	13	; self.next_item_args = slot3
		 92	[1091]	JMP  	  3		18	; 	goto 111
		 93	[1093]	UGET 	  3		2	; slot3 = uv2"log"
		 94	[1093]	TGETS	  3	3	7	; slot3 = uv2"log".error
		 95	[1093]	KSTR 	  4		6	; slot4 = "FORCING RELOAD OF GUI ONLY"
		 96	[1093]	CALL 	  3	1	2	;  = uv2"log".error(slot4)
		 97	[1094]	GGET 	  3		17	; slot3 = _env["game"]
		 98	[1094]	MOV  	  4		3	; slot4 = game
		 99	[1094]	TGETS	  3	3	5	; slot3 = game.reload_gui
		100	[1094]	CALL 	  3	1	2	;  = game.reload_gui(game)
		101	[1095]	JMP  	  3		9	; 	goto 111
		102	[1097]	UGET 	  3		2	; slot3 = uv2"log"
		103	[1097]	TGETS	  3	3	7	; slot3 = uv2"log".error
		104	[1097]	KSTR 	  4		4	; slot4 = "FORCING RELOAD OF %s"
		105	[1097]	TGETS	  5	0	3	; slot5 = self.last_item_name
		106	[1097]	CALL 	  3	1	3	;  = uv2"log".error(slot4, self.last_item_name)
		107	[1098]	KPRI 	  3		2	; slot3 = true
		108	[1098]	TSETS	  3	0	14	; self.force_reload = slot3
		109	[1099]	TGETS	  3	0	3	; slot3 = self.last_item_name
		110	[1099]	TSETS	  3	0	15	; self.next_item_name = self.last_item_name
		111	[1101]	RET0 	  0		1	; return
		112	[1105]	TGETS	  3	0	19	; slot3 = self.active_item
		113	[1105]	ISF  	   		3	; if not self.active_item
		114	[1105]	JMP  	  4		13	; 	goto 128
		115	[1105]	TGETS	  3	0	19	; slot3 = self.active_item
		116	[1105]	TGETS	  3	3	2	; slot3 = self.active_item.keypressed
		117	[1105]	ISF  	   		3	; if not self.active_item.keypressed
		118	[1105]	JMP  	  4		9	; 	goto 128
		119	[1106]	TGETS	  3	0	19	; slot3 = self.active_item
		120	[1106]	MOV  	  4		3	; slot4 = self.active_item
		121	[1106]	TGETS	  3	3	2	; slot3 = self.active_item.keypressed
		122	[1106]	MOV  	  5		1	; slot5 = key
		123	[1106]	MOV  	  6		2	; slot6 = isrepeat
		124	[1106]	CALL 	  3	2	4	; slot3 = self.active_item.keypressed(self.active_item, key, isrepeat)
		125	[1106]	ISF  	   		3	; if not slot3
		126	[1106]	JMP  	  4		1	; 	goto 128
		127	[1107]	RET0 	  0		1	; return
		128	[1111]	UGET 	  3		0	; slot3 = uv0"ISM"
		129	[1111]	ISF  	   		3	; if not uv0"ISM"
		130	[1111]	JMP  	  4		18	; 	goto 149
		131	[1112]	TGETS	  3	0	19	; slot3 = self.active_item
		132	[1112]	ISF  	   		3	; if not self.active_item
		133	[1112]	JMP  	  4		8	; 	goto 142
		134	[1112]	TGETS	  3	0	19	; slot3 = self.active_item
		135	[1112]	TGETS	  3	3	1	; slot3 = self.active_item.get_ism_state
		136	[1112]	ISF  	   		3	; if not self.active_item.get_ism_state
		137	[1112]	JMP  	  4		4	; 	goto 142
		138	[1112]	TGETS	  3	0	19	; slot3 = self.active_item
		139	[1112]	MOV  	  4		3	; slot4 = self.active_item
		140	[1112]	TGETS	  3	3	1	; slot3 = self.active_item.get_ism_state
		141	[1112]	CALL 	  3	2	2	; slot3 = self.active_item.get_ism_state(self.active_item)
		142	[1113]	UGET 	  4		0	; slot4 = uv0"ISM"
		143	[1113]	MOV  	  5		4	; slot5 = uv0"ISM"
		144	[1113]	TGETS	  4	4	0	; slot4 = uv0"ISM".proc_key
		145	[1113]	MOV  	  6		3	; slot6 = state
		146	[1113]	MOV  	  7		1	; slot7 = key
		147	[1113]	MOV  	  8		2	; slot8 = isrepeat
		148	[1113]	CALL 	  4	1	5	;  = uv0"ISM".proc_key(uv0"ISM", state, key, isrepeat)
		149	[1115]	RET0 	  0		1	; return
	123	[1066]	TSETS	 23	22	44	; director.keypressed = slot23
	124	[1116]	GGET 	 22		99	; slot22 = _env["director"]
	125	[1119]	FNEW 	 23		41	; @./all/director.lua:1116-1119: 3 args, 1 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		;;;; variable info ;;;;
		  0-22:	self
		  0-22:	key
		  0-22:	isrepeat
		;;;; instructions ;;;;
		  1	[1117]	TGETS	  3	0	2	; slot3 = self.active_item
		  2	[1117]	ISF  	   		3	; if not self.active_item
		  3	[1117]	JMP  	  4		10	; 	goto 14
		  4	[1117]	TGETS	  3	0	2	; slot3 = self.active_item
		  5	[1117]	TGETS	  3	3	1	; slot3 = self.active_item.keyreleased
		  6	[1117]	ISF  	   		3	; if not self.active_item.keyreleased
		  7	[1117]	JMP  	  4		6	; 	goto 14
		  8	[1117]	TGETS	  3	0	2	; slot3 = self.active_item
		  9	[1117]	MOV  	  4		3	; slot4 = self.active_item
		 10	[1117]	TGETS	  3	3	1	; slot3 = self.active_item.keyreleased
		 11	[1117]	MOV  	  5		1	; slot5 = key
		 12	[1117]	MOV  	  6		2	; slot6 = isrepeat
		 13	[1117]	CALL 	  3	1	4	;  = self.active_item.keyreleased(self.active_item, key, isrepeat)
		 14	[1118]	UGET 	  3		0	; slot3 = uv0"ISM"
		 15	[1118]	ISF  	   		3	; if not uv0"ISM"
		 16	[1118]	JMP  	  4		5	; 	goto 22
		 17	[1118]	UGET 	  3		0	; slot3 = uv0"ISM"
		 18	[1118]	MOV  	  4		3	; slot4 = uv0"ISM"
		 19	[1118]	TGETS	  3	3	0	; slot3 = uv0"ISM".proc_key_released
		 20	[1118]	MOV  	  5		1	; slot5 = key
		 21	[1118]	CALL 	  3	1	3	;  = uv0"ISM".proc_key_released(uv0"ISM", key)
		 22	[1119]	RET0 	  0		1	; return
	126	[1116]	TSETS	 23	22	42	; director.keyreleased = slot23
	127	[1120]	GGET 	 22		99	; slot22 = _env["director"]
	128	[1122]	FNEW 	 23		39	; @./all/director.lua:1120-1122: 2 args, 0 upvalues, 5 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-13:	self
		  0-13:	t
		;;;; instructions ;;;;
		  1	[1121]	TGETS	  2	0	1	; slot2 = self.active_item
		  2	[1121]	ISF  	   		2	; if not self.active_item
		  3	[1121]	JMP  	  3		9	; 	goto 13
		  4	[1121]	TGETS	  2	0	1	; slot2 = self.active_item
		  5	[1121]	TGETS	  2	2	0	; slot2 = self.active_item.textinput
		  6	[1121]	ISF  	   		2	; if not self.active_item.textinput
		  7	[1121]	JMP  	  3		5	; 	goto 13
		  8	[1121]	TGETS	  2	0	1	; slot2 = self.active_item
		  9	[1121]	MOV  	  3		2	; slot3 = self.active_item
		 10	[1121]	TGETS	  2	2	0	; slot2 = self.active_item.textinput
		 11	[1121]	MOV  	  4		1	; slot4 = t
		 12	[1121]	CALL 	  2	1	3	;  = self.active_item.textinput(self.active_item, t)
		 13	[1122]	RET0 	  0		1	; return
	129	[1120]	TSETS	 23	22	40	; director.textinput = slot23
	130	[1123]	GGET 	 22		99	; slot22 = _env["director"]
	131	[1133]	FNEW 	 23		37	; @./all/director.lua:1123-1133: 5 args, 2 upvalues, 11 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		  1:	log
		;;;; variable info ;;;;
		  0-43:	self
		  0-43:	x
		  0-43:	y
		  0-43:	button
		  0-43:	istouch
		;;;; instructions ;;;;
		  1	[1124]	UGET 	  5		0	; slot5 = uv0"ISM"
		  2	[1124]	ISF  	   		5	; if not uv0"ISM"
		  3	[1124]	JMP  	  6		7	; 	goto 11
		  4	[1124]	IST  	   		4	; if istouch
		  5	[1124]	JMP  	  5		5	; 	goto 11
		  6	[1124]	UGET 	  5		0	; slot5 = uv0"ISM"
		  7	[1124]	MOV  	  6		5	; slot6 = uv0"ISM"
		  8	[1124]	TGETS	  5	5	10	; slot5 = uv0"ISM".set_last_input
		  9	[1124]	GGET 	  7		9	; slot7 = _env["I_MOUSE"]
		 10	[1124]	CALL 	  5	1	3	;  = uv0"ISM".set_last_input(uv0"ISM", I_MOUSE)
		 11	[1126]	GGET 	  5		8	; slot5 = _env["DEBUG_CLICK"]
		 12	[1126]	ISF  	   		5	; if not DEBUG_CLICK
		 13	[1126]	JMP  	  6		6	; 	goto 20
		 14	[1127]	UGET 	  5		1	; slot5 = uv1"log"
		 15	[1127]	TGETS	  5	5	7	; slot5 = uv1"log".debug
		 16	[1127]	KSTR 	  6		6	; slot6 = "mouspressed at (%i,%i)"
		 17	[1127]	MOV  	  7		1	; slot7 = x
		 18	[1127]	MOV  	  8		2	; slot8 = y
		 19	[1127]	CALL 	  5	1	4	;  = uv1"log".debug(slot6, x, y)
		 20	[1129]	TGETS	  5	0	5	; slot5 = self.cursor_down
		 21	[1129]	ISF  	   		5	; if not self.cursor_down
		 22	[1129]	JMP  	  6		5	; 	goto 28
		 23	[1130]	GGET 	  5		4	; slot5 = _env["love"]
		 24	[1130]	TGETS	  5	5	3	; slot5 = love.mouse
		 25	[1130]	TGETS	  5	5	2	; slot5 = love.mouse.setCursor
		 26	[1130]	TGETS	  6	0	5	; slot6 = self.cursor_down
		 27	[1130]	CALL 	  5	1	2	;  = love.mouse.setCursor(self.cursor_down)
		 28	[1132]	TGETS	  5	0	1	; slot5 = self.active_item
		 29	[1132]	ISF  	   		5	; if not self.active_item
		 30	[1132]	JMP  	  6		12	; 	goto 43
		 31	[1132]	TGETS	  5	0	1	; slot5 = self.active_item
		 32	[1132]	TGETS	  5	5	0	; slot5 = self.active_item.mousepressed
		 33	[1132]	ISF  	   		5	; if not self.active_item.mousepressed
		 34	[1132]	JMP  	  6		8	; 	goto 43
		 35	[1132]	TGETS	  5	0	1	; slot5 = self.active_item
		 36	[1132]	MOV  	  6		5	; slot6 = self.active_item
		 37	[1132]	TGETS	  5	5	0	; slot5 = self.active_item.mousepressed
		 38	[1132]	MOV  	  7		1	; slot7 = x
		 39	[1132]	MOV  	  8		2	; slot8 = y
		 40	[1132]	MOV  	  9		3	; slot9 = button
		 41	[1132]	MOV  	 10		4	; slot10 = istouch
		 42	[1132]	CALL 	  5	1	6	;  = self.active_item.mousepressed(self.active_item, x, y, button, istouch)
		 43	[1133]	RET0 	  0		1	; return
	132	[1123]	TSETS	 23	22	38	; director.mousepressed = slot23
	133	[1134]	GGET 	 22		99	; slot22 = _env["director"]
	134	[1139]	FNEW 	 23		35	; @./all/director.lua:1134-1139: 5 args, 0 upvalues, 11 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-24:	self
		  0-24:	x
		  0-24:	y
		  0-24:	button
		  0-24:	istouch
		;;;; instructions ;;;;
		  1	[1135]	TGETS	  5	0	5	; slot5 = self.cursor_up
		  2	[1135]	ISF  	   		5	; if not self.cursor_up
		  3	[1135]	JMP  	  6		5	; 	goto 9
		  4	[1136]	GGET 	  5		4	; slot5 = _env["love"]
		  5	[1136]	TGETS	  5	5	3	; slot5 = love.mouse
		  6	[1136]	TGETS	  5	5	2	; slot5 = love.mouse.setCursor
		  7	[1136]	TGETS	  6	0	5	; slot6 = self.cursor_up
		  8	[1136]	CALL 	  5	1	2	;  = love.mouse.setCursor(self.cursor_up)
		  9	[1138]	TGETS	  5	0	1	; slot5 = self.active_item
		 10	[1138]	ISF  	   		5	; if not self.active_item
		 11	[1138]	JMP  	  6		12	; 	goto 24
		 12	[1138]	TGETS	  5	0	1	; slot5 = self.active_item
		 13	[1138]	TGETS	  5	5	0	; slot5 = self.active_item.mousereleased
		 14	[1138]	ISF  	   		5	; if not self.active_item.mousereleased
		 15	[1138]	JMP  	  6		8	; 	goto 24
		 16	[1138]	TGETS	  5	0	1	; slot5 = self.active_item
		 17	[1138]	MOV  	  6		5	; slot6 = self.active_item
		 18	[1138]	TGETS	  5	5	0	; slot5 = self.active_item.mousereleased
		 19	[1138]	MOV  	  7		1	; slot7 = x
		 20	[1138]	MOV  	  8		2	; slot8 = y
		 21	[1138]	MOV  	  9		3	; slot9 = button
		 22	[1138]	MOV  	 10		4	; slot10 = istouch
		 23	[1138]	CALL 	  5	1	6	;  = self.active_item.mousereleased(self.active_item, x, y, button, istouch)
		 24	[1139]	RET0 	  0		1	; return
	135	[1134]	TSETS	 23	22	36	; director.mousereleased = slot23
	136	[1140]	GGET 	 22		99	; slot22 = _env["director"]
	137	[1143]	FNEW 	 23		33	; @./all/director.lua:1140-1143: 3 args, 1 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		;;;; variable info ;;;;
		  0-22:	self
		  0-22:	dx
		  0-22:	dy
		;;;; instructions ;;;;
		  1	[1141]	UGET 	  3		0	; slot3 = uv0"ISM"
		  2	[1141]	ISF  	   		3	; if not uv0"ISM"
		  3	[1141]	JMP  	  4		5	; 	goto 9
		  4	[1141]	UGET 	  3		0	; slot3 = uv0"ISM"
		  5	[1141]	MOV  	  4		3	; slot4 = uv0"ISM"
		  6	[1141]	TGETS	  3	3	3	; slot3 = uv0"ISM".set_last_input
		  7	[1141]	GGET 	  5		2	; slot5 = _env["I_MOUSE"]
		  8	[1141]	CALL 	  3	1	3	;  = uv0"ISM".set_last_input(uv0"ISM", I_MOUSE)
		  9	[1142]	TGETS	  3	0	1	; slot3 = self.active_item
		 10	[1142]	ISF  	   		3	; if not self.active_item
		 11	[1142]	JMP  	  4		10	; 	goto 22
		 12	[1142]	TGETS	  3	0	1	; slot3 = self.active_item
		 13	[1142]	TGETS	  3	3	0	; slot3 = self.active_item.wheelmoved
		 14	[1142]	ISF  	   		3	; if not self.active_item.wheelmoved
		 15	[1142]	JMP  	  4		6	; 	goto 22
		 16	[1142]	TGETS	  3	0	1	; slot3 = self.active_item
		 17	[1142]	MOV  	  4		3	; slot4 = self.active_item
		 18	[1142]	TGETS	  3	3	0	; slot3 = self.active_item.wheelmoved
		 19	[1142]	MOV  	  5		1	; slot5 = dx
		 20	[1142]	MOV  	  6		2	; slot6 = dy
		 21	[1142]	CALL 	  3	1	4	;  = self.active_item.wheelmoved(self.active_item, dx, dy)
		 22	[1143]	RET0 	  0		1	; return
	138	[1140]	TSETS	 23	22	34	; director.wheelmoved = slot23
	139	[1144]	GGET 	 22		99	; slot22 = _env["director"]
	140	[1147]	FNEW 	 23		31	; @./all/director.lua:1144-1147: 7 args, 1 upvalues, 15 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		;;;; variable info ;;;;
		  0-26:	self
		  0-26:	id
		  0-26:	x
		  0-26:	y
		  0-26:	dx
		  0-26:	dy
		  0-26:	pressure
		;;;; instructions ;;;;
		  1	[1145]	UGET 	  7		0	; slot7 = uv0"ISM"
		  2	[1145]	ISF  	   		7	; if not uv0"ISM"
		  3	[1145]	JMP  	  8		5	; 	goto 9
		  4	[1145]	UGET 	  7		0	; slot7 = uv0"ISM"
		  5	[1145]	MOV  	  8		7	; slot8 = uv0"ISM"
		  6	[1145]	TGETS	  7	7	3	; slot7 = uv0"ISM".set_last_input
		  7	[1145]	GGET 	  9		2	; slot9 = _env["I_TOUCH"]
		  8	[1145]	CALL 	  7	1	3	;  = uv0"ISM".set_last_input(uv0"ISM", I_TOUCH)
		  9	[1146]	TGETS	  7	0	1	; slot7 = self.active_item
		 10	[1146]	ISF  	   		7	; if not self.active_item
		 11	[1146]	JMP  	  8		14	; 	goto 26
		 12	[1146]	TGETS	  7	0	1	; slot7 = self.active_item
		 13	[1146]	TGETS	  7	7	0	; slot7 = self.active_item.touchpressed
		 14	[1146]	ISF  	   		7	; if not self.active_item.touchpressed
		 15	[1146]	JMP  	  8		10	; 	goto 26
		 16	[1146]	TGETS	  7	0	1	; slot7 = self.active_item
		 17	[1146]	MOV  	  8		7	; slot8 = self.active_item
		 18	[1146]	TGETS	  7	7	0	; slot7 = self.active_item.touchpressed
		 19	[1146]	MOV  	  9		1	; slot9 = id
		 20	[1146]	MOV  	 10		2	; slot10 = x
		 21	[1146]	MOV  	 11		3	; slot11 = y
		 22	[1146]	MOV  	 12		4	; slot12 = dx
		 23	[1146]	MOV  	 13		5	; slot13 = dy
		 24	[1146]	MOV  	 14		6	; slot14 = pressure
		 25	[1146]	CALL 	  7	1	8	;  = self.active_item.touchpressed(self.active_item, id, x, y, dx, dy, pressure)
		 26	[1147]	RET0 	  0		1	; return
	141	[1144]	TSETS	 23	22	32	; director.touchpressed = slot23
	142	[1149]	GGET 	 22		99	; slot22 = _env["director"]
	143	[1151]	FNEW 	 23		29	; @./all/director.lua:1149-1151: 7 args, 0 upvalues, 15 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-18:	self
		  0-18:	id
		  0-18:	x
		  0-18:	y
		  0-18:	dx
		  0-18:	dy
		  0-18:	pressure
		;;;; instructions ;;;;
		  1	[1150]	TGETS	  7	0	1	; slot7 = self.active_item
		  2	[1150]	ISF  	   		7	; if not self.active_item
		  3	[1150]	JMP  	  8		14	; 	goto 18
		  4	[1150]	TGETS	  7	0	1	; slot7 = self.active_item
		  5	[1150]	TGETS	  7	7	0	; slot7 = self.active_item.touchreleased
		  6	[1150]	ISF  	   		7	; if not self.active_item.touchreleased
		  7	[1150]	JMP  	  8		10	; 	goto 18
		  8	[1150]	TGETS	  7	0	1	; slot7 = self.active_item
		  9	[1150]	MOV  	  8		7	; slot8 = self.active_item
		 10	[1150]	TGETS	  7	7	0	; slot7 = self.active_item.touchreleased
		 11	[1150]	MOV  	  9		1	; slot9 = id
		 12	[1150]	MOV  	 10		2	; slot10 = x
		 13	[1150]	MOV  	 11		3	; slot11 = y
		 14	[1150]	MOV  	 12		4	; slot12 = dx
		 15	[1150]	MOV  	 13		5	; slot13 = dy
		 16	[1150]	MOV  	 14		6	; slot14 = pressure
		 17	[1150]	CALL 	  7	1	8	;  = self.active_item.touchreleased(self.active_item, id, x, y, dx, dy, pressure)
		 18	[1151]	RET0 	  0		1	; return
	144	[1149]	TSETS	 23	22	30	; director.touchreleased = slot23
	145	[1153]	GGET 	 22		99	; slot22 = _env["director"]
	146	[1156]	FNEW 	 23		27	; @./all/director.lua:1153-1156: 7 args, 1 upvalues, 15 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		;;;; variable info ;;;;
		  0-26:	self
		  0-26:	id
		  0-26:	x
		  0-26:	y
		  0-26:	dx
		  0-26:	dy
		  0-26:	pressure
		;;;; instructions ;;;;
		  1	[1154]	UGET 	  7		0	; slot7 = uv0"ISM"
		  2	[1154]	ISF  	   		7	; if not uv0"ISM"
		  3	[1154]	JMP  	  8		5	; 	goto 9
		  4	[1154]	UGET 	  7		0	; slot7 = uv0"ISM"
		  5	[1154]	MOV  	  8		7	; slot8 = uv0"ISM"
		  6	[1154]	TGETS	  7	7	3	; slot7 = uv0"ISM".set_last_input
		  7	[1154]	GGET 	  9		2	; slot9 = _env["I_TOUCH"]
		  8	[1154]	CALL 	  7	1	3	;  = uv0"ISM".set_last_input(uv0"ISM", I_TOUCH)
		  9	[1155]	TGETS	  7	0	1	; slot7 = self.active_item
		 10	[1155]	ISF  	   		7	; if not self.active_item
		 11	[1155]	JMP  	  8		14	; 	goto 26
		 12	[1155]	TGETS	  7	0	1	; slot7 = self.active_item
		 13	[1155]	TGETS	  7	7	0	; slot7 = self.active_item.touchmoved
		 14	[1155]	ISF  	   		7	; if not self.active_item.touchmoved
		 15	[1155]	JMP  	  8		10	; 	goto 26
		 16	[1155]	TGETS	  7	0	1	; slot7 = self.active_item
		 17	[1155]	MOV  	  8		7	; slot8 = self.active_item
		 18	[1155]	TGETS	  7	7	0	; slot7 = self.active_item.touchmoved
		 19	[1155]	MOV  	  9		1	; slot9 = id
		 20	[1155]	MOV  	 10		2	; slot10 = x
		 21	[1155]	MOV  	 11		3	; slot11 = y
		 22	[1155]	MOV  	 12		4	; slot12 = dx
		 23	[1155]	MOV  	 13		5	; slot13 = dy
		 24	[1155]	MOV  	 14		6	; slot14 = pressure
		 25	[1155]	CALL 	  7	1	8	;  = self.active_item.touchmoved(self.active_item, id, x, y, dx, dy, pressure)
		 26	[1156]	RET0 	  0		1	; return
	147	[1153]	TSETS	 23	22	28	; director.touchmoved = slot23
	148	[1158]	GGET 	 22		99	; slot22 = _env["director"]
	149	[1167]	FNEW 	 23		25	; @./all/director.lua:1158-1167: 4 args, 0 upvalues, 9 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-15:	self
		  0-15:	joystick
		  0-15:	axis
		  0-15:	value
		;;;; instructions ;;;;
		  1	[1166]	TGETS	  4	0	1	; slot4 = self.active_item
		  2	[1166]	ISF  	   		4	; if not self.active_item
		  3	[1166]	JMP  	  5		11	; 	goto 15
		  4	[1166]	TGETS	  4	0	1	; slot4 = self.active_item
		  5	[1166]	TGETS	  4	4	0	; slot4 = self.active_item.gamepadaxis
		  6	[1166]	ISF  	   		4	; if not self.active_item.gamepadaxis
		  7	[1166]	JMP  	  5		7	; 	goto 15
		  8	[1166]	TGETS	  4	0	1	; slot4 = self.active_item
		  9	[1166]	MOV  	  5		4	; slot5 = self.active_item
		 10	[1166]	TGETS	  4	4	0	; slot4 = self.active_item.gamepadaxis
		 11	[1166]	MOV  	  6		1	; slot6 = joystick
		 12	[1166]	MOV  	  7		2	; slot7 = axis
		 13	[1166]	MOV  	  8		3	; slot8 = value
		 14	[1166]	CALL 	  4	1	5	;  = self.active_item.gamepadaxis(self.active_item, joystick, axis, value)
		 15	[1167]	RET0 	  0		1	; return
	150	[1158]	TSETS	 23	22	26	; director.gamepadaxis = slot23
	151	[1169]	GGET 	 22		99	; slot22 = _env["director"]
	152	[1176]	FNEW 	 23		23	; @./all/director.lua:1169-1176: 3 args, 1 upvalues, 9 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		;;;; variable info ;;;;
		  0-43:	self
		  0-43:	joystick
		  0-43:	button
		  32-42:	state
		;;;; instructions ;;;;
		  1	[1170]	UGET 	  3		0	; slot3 = uv0"ISM"
		  2	[1170]	ISF  	   		3	; if not uv0"ISM"
		  3	[1170]	JMP  	  4		5	; 	goto 9
		  4	[1170]	UGET 	  3		0	; slot3 = uv0"ISM"
		  5	[1170]	MOV  	  4		3	; slot4 = uv0"ISM"
		  6	[1170]	TGETS	  3	3	5	; slot3 = uv0"ISM".set_last_input
		  7	[1170]	GGET 	  5		4	; slot5 = _env["I_GAMEPAD"]
		  8	[1170]	CALL 	  3	1	3	;  = uv0"ISM".set_last_input(uv0"ISM", I_GAMEPAD)
		  9	[1171]	TGETS	  3	0	3	; slot3 = self.active_item
		 10	[1171]	ISF  	   		3	; if not self.active_item
		 11	[1171]	JMP  	  4		31	; 	goto 43
		 12	[1172]	TGETS	  3	0	3	; slot3 = self.active_item
		 13	[1172]	TGETS	  3	3	2	; slot3 = self.active_item.gamepadpressed
		 14	[1172]	ISF  	   		3	; if not self.active_item.gamepadpressed
		 15	[1172]	JMP  	  4		6	; 	goto 22
		 16	[1172]	TGETS	  3	0	3	; slot3 = self.active_item
		 17	[1172]	MOV  	  4		3	; slot4 = self.active_item
		 18	[1172]	TGETS	  3	3	2	; slot3 = self.active_item.gamepadpressed
		 19	[1172]	MOV  	  5		1	; slot5 = joystick
		 20	[1172]	MOV  	  6		2	; slot6 = button
		 21	[1172]	CALL 	  3	1	4	;  = self.active_item.gamepadpressed(self.active_item, joystick, button)
		 22	[1173]	TGETS	  3	0	3	; slot3 = self.active_item
		 23	[1173]	ISF  	   		3	; if not self.active_item
		 24	[1173]	JMP  	  4		8	; 	goto 33
		 25	[1173]	TGETS	  3	0	3	; slot3 = self.active_item
		 26	[1173]	TGETS	  3	3	1	; slot3 = self.active_item.get_ism_state
		 27	[1173]	ISF  	   		3	; if not self.active_item.get_ism_state
		 28	[1173]	JMP  	  4		4	; 	goto 33
		 29	[1173]	TGETS	  3	0	3	; slot3 = self.active_item
		 30	[1173]	MOV  	  4		3	; slot4 = self.active_item
		 31	[1173]	TGETS	  3	3	1	; slot3 = self.active_item.get_ism_state
		 32	[1173]	CALL 	  3	2	2	; slot3 = self.active_item.get_ism_state(self.active_item)
		 33	[1174]	UGET 	  4		0	; slot4 = uv0"ISM"
		 34	[1174]	ISF  	   		4	; if not uv0"ISM"
		 35	[1174]	JMP  	  5		7	; 	goto 43
		 36	[1174]	UGET 	  4		0	; slot4 = uv0"ISM"
		 37	[1174]	MOV  	  5		4	; slot5 = uv0"ISM"
		 38	[1174]	TGETS	  4	4	0	; slot4 = uv0"ISM".proc_button
		 39	[1174]	MOV  	  6		3	; slot6 = state
		 40	[1174]	MOV  	  7		1	; slot7 = joystick
		 41	[1174]	MOV  	  8		2	; slot8 = button
		 42	[1174]	CALL 	  4	1	5	;  = uv0"ISM".proc_button(uv0"ISM", state, joystick, button)
		 43	[1176]	RET0 	  0		1	; return
	153	[1169]	TSETS	 23	22	24	; director.gamepadpressed = slot23
	154	[1178]	GGET 	 22		99	; slot22 = _env["director"]
	155	[1180]	FNEW 	 23		21	; @./all/director.lua:1178-1180: 3 args, 0 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-14:	self
		  0-14:	joystick
		  0-14:	button
		;;;; instructions ;;;;
		  1	[1179]	TGETS	  3	0	1	; slot3 = self.active_item
		  2	[1179]	ISF  	   		3	; if not self.active_item
		  3	[1179]	JMP  	  4		10	; 	goto 14
		  4	[1179]	TGETS	  3	0	1	; slot3 = self.active_item
		  5	[1179]	TGETS	  3	3	0	; slot3 = self.active_item.gamepadreleased
		  6	[1179]	ISF  	   		3	; if not self.active_item.gamepadreleased
		  7	[1179]	JMP  	  4		6	; 	goto 14
		  8	[1179]	TGETS	  3	0	1	; slot3 = self.active_item
		  9	[1179]	MOV  	  4		3	; slot4 = self.active_item
		 10	[1179]	TGETS	  3	3	0	; slot3 = self.active_item.gamepadreleased
		 11	[1179]	MOV  	  5		1	; slot5 = joystick
		 12	[1179]	MOV  	  6		2	; slot6 = button
		 13	[1179]	CALL 	  3	1	4	;  = self.active_item.gamepadreleased(self.active_item, joystick, button)
		 14	[1180]	RET0 	  0		1	; return
	156	[1178]	TSETS	 23	22	22	; director.gamepadreleased = slot23
	157	[1182]	GGET 	 22		99	; slot22 = _env["director"]
	158	[1187]	FNEW 	 23		19	; @./all/director.lua:1182-1187: 3 args, 0 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-14:	self
		  0-14:	joystick
		  0-14:	button
		;;;; instructions ;;;;
		  1	[1186]	TGETS	  3	0	1	; slot3 = self.active_item
		  2	[1186]	ISF  	   		3	; if not self.active_item
		  3	[1186]	JMP  	  4		10	; 	goto 14
		  4	[1186]	TGETS	  3	0	1	; slot3 = self.active_item
		  5	[1186]	TGETS	  3	3	0	; slot3 = self.active_item.joystickpressed
		  6	[1186]	ISF  	   		3	; if not self.active_item.joystickpressed
		  7	[1186]	JMP  	  4		6	; 	goto 14
		  8	[1186]	TGETS	  3	0	1	; slot3 = self.active_item
		  9	[1186]	MOV  	  4		3	; slot4 = self.active_item
		 10	[1186]	TGETS	  3	3	0	; slot3 = self.active_item.joystickpressed
		 11	[1186]	MOV  	  5		1	; slot5 = joystick
		 12	[1186]	MOV  	  6		2	; slot6 = button
		 13	[1186]	CALL 	  3	1	4	;  = self.active_item.joystickpressed(self.active_item, joystick, button)
		 14	[1187]	RET0 	  0		1	; return
	159	[1182]	TSETS	 23	22	20	; director.joystickpressed = slot23
	160	[1189]	GGET 	 22		99	; slot22 = _env["director"]
	161	[1191]	FNEW 	 23		17	; @./all/director.lua:1189-1191: 3 args, 0 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		;;;; variable info ;;;;
		  0-14:	self
		  0-14:	joystick
		  0-14:	button
		;;;; instructions ;;;;
		  1	[1190]	TGETS	  3	0	1	; slot3 = self.active_item
		  2	[1190]	ISF  	   		3	; if not self.active_item
		  3	[1190]	JMP  	  4		10	; 	goto 14
		  4	[1190]	TGETS	  3	0	1	; slot3 = self.active_item
		  5	[1190]	TGETS	  3	3	0	; slot3 = self.active_item.joystickreleased
		  6	[1190]	ISF  	   		3	; if not self.active_item.joystickreleased
		  7	[1190]	JMP  	  4		6	; 	goto 14
		  8	[1190]	TGETS	  3	0	1	; slot3 = self.active_item
		  9	[1190]	MOV  	  4		3	; slot4 = self.active_item
		 10	[1190]	TGETS	  3	3	0	; slot3 = self.active_item.joystickreleased
		 11	[1190]	MOV  	  5		1	; slot5 = joystick
		 12	[1190]	MOV  	  6		2	; slot6 = button
		 13	[1190]	CALL 	  3	1	4	;  = self.active_item.joystickreleased(self.active_item, joystick, button)
		 14	[1191]	RET0 	  0		1	; return
	162	[1189]	TSETS	 23	22	18	; director.joystickreleased = slot23
	163	[1193]	GGET 	 22		99	; slot22 = _env["director"]
	164	[1197]	FNEW 	 23		15	; @./all/director.lua:1193-1197: 2 args, 2 upvalues, 5 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		  1:	signal
		;;;; variable info ;;;;
		  0-26:	self
		  0-26:	joystick
		;;;; instructions ;;;;
		  1	[1194]	UGET 	  2		0	; slot2 = uv0"ISM"
		  2	[1194]	ISF  	   		2	; if not uv0"ISM"
		  3	[1194]	JMP  	  3		5	; 	goto 9
		  4	[1194]	UGET 	  2		0	; slot2 = uv0"ISM"
		  5	[1194]	MOV  	  3		2	; slot3 = uv0"ISM"
		  6	[1194]	TGETS	  2	2	3	; slot2 = uv0"ISM".joystickadded
		  7	[1194]	MOV  	  4		1	; slot4 = joystick
		  8	[1194]	CALL 	  2	1	3	;  = uv0"ISM".joystickadded(uv0"ISM", joystick)
		  9	[1195]	TGETS	  2	0	2	; slot2 = self.active_item
		 10	[1195]	ISF  	   		2	; if not self.active_item
		 11	[1195]	JMP  	  3		9	; 	goto 21
		 12	[1195]	TGETS	  2	0	2	; slot2 = self.active_item
		 13	[1195]	TGETS	  2	2	3	; slot2 = self.active_item.joystickadded
		 14	[1195]	ISF  	   		2	; if not self.active_item.joystickadded
		 15	[1195]	JMP  	  3		5	; 	goto 21
		 16	[1195]	TGETS	  2	0	2	; slot2 = self.active_item
		 17	[1195]	MOV  	  3		2	; slot3 = self.active_item
		 18	[1195]	TGETS	  2	2	3	; slot2 = self.active_item.joystickadded
		 19	[1195]	MOV  	  4		1	; slot4 = joystick
		 20	[1195]	CALL 	  2	1	3	;  = self.active_item.joystickadded(self.active_item, joystick)
		 21	[1196]	UGET 	  2		1	; slot2 = uv1"signal"
		 22	[1196]	TGETS	  2	2	1	; slot2 = uv1"signal".emit
		 23	[1196]	KSTR 	  3		0	; slot3 = "joystick-added"
		 24	[1196]	MOV  	  4		1	; slot4 = joystick
		 25	[1196]	CALL 	  2	1	3	;  = uv1"signal".emit(slot3, joystick)
		 26	[1197]	RET0 	  0		1	; return
	165	[1193]	TSETS	 23	22	16	; director.joystickadded = slot23
	166	[1199]	GGET 	 22		99	; slot22 = _env["director"]
	167	[1203]	FNEW 	 23		13	; @./all/director.lua:1199-1203: 2 args, 2 upvalues, 5 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	ISM
		  1:	signal
		;;;; variable info ;;;;
		  0-26:	self
		  0-26:	joystick
		;;;; instructions ;;;;
		  1	[1200]	UGET 	  2		0	; slot2 = uv0"ISM"
		  2	[1200]	ISF  	   		2	; if not uv0"ISM"
		  3	[1200]	JMP  	  3		5	; 	goto 9
		  4	[1200]	UGET 	  2		0	; slot2 = uv0"ISM"
		  5	[1200]	MOV  	  3		2	; slot3 = uv0"ISM"
		  6	[1200]	TGETS	  2	2	3	; slot2 = uv0"ISM".joystickremoved
		  7	[1200]	MOV  	  4		1	; slot4 = joystick
		  8	[1200]	CALL 	  2	1	3	;  = uv0"ISM".joystickremoved(uv0"ISM", joystick)
		  9	[1201]	TGETS	  2	0	2	; slot2 = self.active_item
		 10	[1201]	ISF  	   		2	; if not self.active_item
		 11	[1201]	JMP  	  3		9	; 	goto 21
		 12	[1201]	TGETS	  2	0	2	; slot2 = self.active_item
		 13	[1201]	TGETS	  2	2	3	; slot2 = self.active_item.joystickremoved
		 14	[1201]	ISF  	   		2	; if not self.active_item.joystickremoved
		 15	[1201]	JMP  	  3		5	; 	goto 21
		 16	[1201]	TGETS	  2	0	2	; slot2 = self.active_item
		 17	[1201]	MOV  	  3		2	; slot3 = self.active_item
		 18	[1201]	TGETS	  2	2	3	; slot2 = self.active_item.joystickremoved
		 19	[1201]	MOV  	  4		1	; slot4 = joystick
		 20	[1201]	CALL 	  2	1	3	;  = self.active_item.joystickremoved(self.active_item, joystick)
		 21	[1202]	UGET 	  2		1	; slot2 = uv1"signal"
		 22	[1202]	TGETS	  2	2	1	; slot2 = uv1"signal".emit
		 23	[1202]	KSTR 	  3		0	; slot3 = "joystick-removed"
		 24	[1202]	MOV  	  4		1	; slot4 = joystick
		 25	[1202]	CALL 	  2	1	3	;  = uv1"signal".emit(slot3, joystick)
		 26	[1203]	RET0 	  0		1	; return
	168	[1199]	TSETS	 23	22	14	; director.joystickremoved = slot23
	169	[1205]	GGET 	 22		99	; slot22 = _env["director"]
	170	[1208]	FNEW 	 23		11	; @./all/director.lua:1205-1208: 3 args, 1 upvalues, 7 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		;;;; variable info ;;;;
		  0-10:	self
		  0-10:	w
		  0-10:	h
		;;;; instructions ;;;;
		  1	[1206]	UGET 	  3		0	; slot3 = uv0"log"
		  2	[1206]	TGETS	  3	3	2	; slot3 = uv0"log".debug
		  3	[1206]	KSTR 	  4		1	; slot4 = ">>>>>>>>> screen size changed to %s,%s"
		  4	[1206]	MOV  	  5		1	; slot5 = w
		  5	[1206]	MOV  	  6		2	; slot6 = h
		  6	[1206]	CALL 	  3	1	4	;  = uv0"log".debug(slot4, w, h)
		  7	[1207]	MOV  	  4		0	; slot4 = self
		  8	[1207]	TGETS	  3	0	0	; slot3 = self.reset_screen_params
		  9	[1207]	CALL 	  3	1	2	;  = self.reset_screen_params(self)
		 10	[1208]	RET0 	  0		1	; return
	171	[1205]	TSETS	 23	22	12	; director.resize = slot23
	172	[1210]	GGET 	 22		99	; slot22 = _env["director"]
	173	[1214]	FNEW 	 23		9	; @./all/director.lua:1210-1214: 2 args, 2 upvalues, 5 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	log
		  1:	signal
		;;;; variable info ;;;;
		  0-23:	self
		  0-23:	focus
		;;;; instructions ;;;;
		  1	[1211]	UGET 	  2		0	; slot2 = uv0"log"
		  2	[1211]	TGETS	  2	2	5	; slot2 = uv0"log".paranoid
		  3	[1211]	KSTR 	  3		4	; slot3 = "++++++++++ focus changed to :%s ++++++++++"
		  4	[1211]	MOV  	  4		1	; slot4 = focus
		  5	[1211]	CALL 	  2	1	3	;  = uv0"log".paranoid(slot3, focus)
		  6	[1212]	TGETS	  2	0	3	; slot2 = self.active_item
		  7	[1212]	ISF  	   		2	; if not self.active_item
		  8	[1212]	JMP  	  3		9	; 	goto 18
		  9	[1212]	TGETS	  2	0	3	; slot2 = self.active_item
		 10	[1212]	TGETS	  2	2	2	; slot2 = self.active_item.focus
		 11	[1212]	ISF  	   		2	; if not self.active_item.focus
		 12	[1212]	JMP  	  3		5	; 	goto 18
		 13	[1212]	TGETS	  2	0	3	; slot2 = self.active_item
		 14	[1212]	MOV  	  3		2	; slot3 = self.active_item
		 15	[1212]	TGETS	  2	2	2	; slot2 = self.active_item.focus
		 16	[1212]	MOV  	  4		1	; slot4 = focus
		 17	[1212]	CALL 	  2	1	3	;  = self.active_item.focus(self.active_item, focus)
		 18	[1213]	UGET 	  2		1	; slot2 = uv1"signal"
		 19	[1213]	TGETS	  2	2	1	; slot2 = uv1"signal".emit
		 20	[1213]	KSTR 	  3		0	; slot3 = "focus-changed"
		 21	[1213]	MOV  	  4		1	; slot4 = focus
		 22	[1213]	CALL 	  2	1	3	;  = uv1"signal".emit(slot3, focus)
		 23	[1214]	RET0 	  0		1	; return
	174	[1210]	TSETS	 23	22	10	; director.focus = slot23
	175	[1218]	GGET 	 22		99	; slot22 = _env["director"]
	176	[1218]	TNEW 	 23		0	; slot23 = new table( array: 0, dict: 1)
	177	[1218]	TSETS	 23	22	8	; director.skip_checks = slot23
	178	[1219]	GGET 	 22		99	; slot22 = _env["director"]
	179	[1219]	TGETS	 22	22	8	; slot22 = director.skip_checks
	180	[1221]	FNEW 	 23		6	; @./all/director.lua:1219-1221: 0 args, 1 upvalues, 1 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	features
		;;;; variable info ;;;;
		;;;; instructions ;;;;
		  1	[1220]	UGET 	  0		0	; slot0 = uv0"features"
		  2	[1220]	TGETS	  0	0	0	; slot0 = uv0"features".show_splash_custom
		  3	[1220]	NOT  	  0		0	; slot0 = not uv0"features".show_splash_custom
		  4	[1220]	RET1 	  0		2	; return slot0
	181	[1219]	TSETS	 23	22	7	; director.skip_checks.check_skip_splash_custom = slot23
	182	[1222]	GGET 	 22		99	; slot22 = _env["director"]
	183	[1222]	TGETS	 22	22	8	; slot22 = director.skip_checks
	184	[1224]	FNEW 	 23		4	; @./all/director.lua:1222-1224: 0 args, 1 upvalues, 1 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	features
		;;;; variable info ;;;;
		;;;; instructions ;;;;
		  1	[1223]	UGET 	  0		0	; slot0 = uv0"features"
		  2	[1223]	TGETS	  0	0	0	; slot0 = uv0"features".show_splash_message
		  3	[1223]	NOT  	  0		0	; slot0 = not uv0"features".show_splash_message
		  4	[1223]	RET1 	  0		2	; return slot0
	185	[1222]	TSETS	 23	22	5	; director.skip_checks.check_skip_splash_message = slot23
	186	[1225]	GGET 	 22		99	; slot22 = _env["director"]
	187	[1225]	TGETS	 22	22	8	; slot22 = director.skip_checks
	188	[1227]	FNEW 	 23		2	; @./all/director.lua:1225-1227: 0 args, 1 upvalues, 2 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	PP
		;;;; variable info ;;;;
		;;;; instructions ;;;;
		  1	[1226]	UGET 	  0		0	; slot0 = uv0"PP"
		  2	[1226]	MOV  	  1		0	; slot1 = uv0"PP"
		  3	[1226]	TGETS	  0	0	0	; slot0 = uv0"PP".should_ask
		  4	[1226]	CALL 	  0	2	2	; slot0 = uv0"PP".should_ask(uv0"PP")
		  5	[1226]	NOT  	  0		0	; slot0 = not slot0
		  6	[1226]	RET1 	  0		2	; return slot0
	189	[1225]	TSETS	 23	22	3	; director.skip_checks.check_skip_consent = slot23
	190	[1228]	GGET 	 22		99	; slot22 = _env["director"]
	191	[1228]	TGETS	 22	22	8	; slot22 = director.skip_checks
	192	[1237]	FNEW 	 23		0	; @./all/director.lua:1228-1237: 0 args, 2 upvalues, 2 slots
		
		;;;; constant tables ;;;;
		;;;; upvalue names ;;;;
		  0:	features
		  1:	storage
		;;;; variable info ;;;;
		  10-17:	global
		;;;; instructions ;;;;
		  1	[1229]	UGET 	  0		0	; slot0 = uv0"features"
		  2	[1229]	TGETS	  0	0	2	; slot0 = uv0"features".show_consent_simple
		  3	[1229]	IST  	   		0	; if uv0"features".show_consent_simple
		  4	[1229]	JMP  	  0		2	; 	goto 7
		  5	[1230]	KPRI 	  0		2	; slot0 = true
		  6	[1230]	RET1 	  0		2	; return slot0
		  7	[1232]	UGET 	  0		1	; slot0 = uv1"storage"
		  8	[1232]	MOV  	  1		0	; slot1 = uv1"storage"
		  9	[1232]	TGETS	  0	0	1	; slot0 = uv1"storage".load_global
		 10	[1232]	CALL 	  0	2	2	; slot0 = uv1"storage".load_global(uv1"storage")
		 11	[1233]	TGETS	  1	0	0	; slot1 = global.simple_privacy_policy_accepted
		 12	[1233]	ISF  	   		1	; if not global.simple_privacy_policy_accepted
		 13	[1233]	JMP  	  2		2	; 	goto 16
		 14	[1234]	KPRI 	  1		2	; slot1 = true
		 15	[1234]	RET1 	  1		2	; return slot1
		 16	[1236]	KPRI 	  1		1	; slot1 = false
		 17	[1236]	RET1 	  1		2	; return slot1
	193	[1228]	TSETS	 23	22	1	; director.skip_checks.check_skip_consent_simple = slot23
	194	[1241]	GGET 	 22		99	; slot22 = _env["director"]
	195	[1241]	UCLO 	  0		0	; nil uvs >= r0; goto 196
	196	[1241]	RET1 	 22		2	; return director
	
