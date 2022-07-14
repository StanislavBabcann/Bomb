
;pre zobrazenie znakov na segmentovkach
BYTE 00000011b
BYTE 10011111b
BYTE 00100101b
BYTE 00001101b
BYTE 10011001b
BYTE 01001001b
BYTE 11000001b
BYTE 00011111b
BYTE 00000001b
BYTE 00011001b
BYTE 00010001b
BYTE 11000001b
BYTE 01100011b
BYTE 10000101b;D 13
BYTE 01100001b;E 14
BYTE 01110001b;F 15

BYTE 11111101b; pomlcka (nic)

;adresy pre extrernu pamat
;10 pre stovky
;11 pre desiatky
;12 pre jednotky

;adresy pre vypis displejov, logicka 0 alebo 1
;15 prvy
;16 druhy

;adresa pre cislo vypisanej konstanty
;17

;adrey pre ulozenie hodnoty pocitadla
;18 jednotky


;adresy pre hadane znaky
; 19 prvy znak
; 20 druhy znak

;adrey pre nacitane znaky
; 21 prvy znak
; 22 druhy znak

;adresa pre druhe pocitadlo
;23

;adresy pre nastavenie pocitadla a kodu - logicke 0 a 1
;25 stovky
;26 desiatky
;27 jednotky
;28
;29


mvi A, 16
mmr A, A
out 447, A
out 479, A
out 495, A
out 255, A
out 383, A

mvi A, 0
smi 25, A
smi 26, A
smi 27, A
smi 28, A
smi 29, A

jmp nastavPocitadloPrvyRiadok

nastavPocitadloPrvyRiadok:
	inn A, 111111110b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 0
	ldr C, B
	cmp C, A
	jzr nastavPocitadloDruhyRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 0
	smi 17, D
	jzr nastavCisloPocitadla

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 1
	smi 17, D
	jzr nastavCisloPocitadla

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 2
	smi 17, D
	jzr nastavCisloPocitadla

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 3
	smi 17, D
	jzr nastavCisloPocitadla


	nastavPocitadloDruhyRiadok:
	inn A, 111111101b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 1
	ldr C, B
	cmp C, A
	jzr nastavPocitadloTretiRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 4
	smi 17, D
	jzr nastavCisloPocitadla

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 5
	smi 17, D
	jzr nastavCisloPocitadla

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 6
	smi 17, D
	jzr nastavCisloPocitadla

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 7
	smi 17, D
	jzr nastavCisloPocitadla


	nastavPocitadloTretiRiadok:
	inn A, 111111011b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 2
	ldr C, B
	cmp C, A
	jzr nastavPocitadloPrvyRiadok
	
	mov B, A
	mvi D, 8
	smi 17, D
	ani B, 1000b
	cmi B, 1000b
	jzr nastavCisloPocitadla

	mov B, A
	mvi D, 9
	smi 17, D
	ani B, 0100b
	cmi B, 0100b
	jzr nastavCisloPocitadla

	jmp nastavPocitadloPrvyRiadok

nastavCisloPocitadla:
	lmi D, 25
	cmi D, 0
	jzr nastavStovky
	lmi D, 26
	cmi D, 0
	jzr nastavDesiatky
	lmi D, 27
	cmi D, 0
	jzr nastavJednotky

nastavStovky:
	mvi D, 1
	smi 25, D
	lmi D, 17
	smi 10, D
	mmr D, D
	out 447, D
	cal cakaj
	jmp nastavPocitadloPrvyRiadok

nastavDesiatky:
	mvi D, 1
	smi 26, D
	lmi D, 17
	smi 11, D
	mmr D, D
	out 479, D
	cal cakaj
	jmp nastavPocitadloPrvyRiadok

nastavJednotky:
	mvi D, 1
	smi 27, D
	lmi D, 17
	smi 12, D
	mmr D, D
	out 495, D
	cal cakaj
	jmp vytvorKodPrvyRiadok

cakaj:
	inn A, 0
	ani A, 00001111b
	cmi A, 1111b
	jne cakaj
	ret
	
vytvorKodPrvyRiadok:
	inn A, 111111110b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 0
	ldr C, B
	cmp C, A
	jzr vytvorKodDruhyRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 0
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 1
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 2
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 3
	smi 17, D
	jzr nastavCisloKodu


	vytvorKodDruhyRiadok:
	inn A, 111111101b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 1
	ldr C, B
	cmp C, A
	jzr vytvorKodTretiRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 4
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 5
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 6
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 7
	smi 17, D
	jzr nastavCisloKodu


	vytvorKodTretiRiadok:
	inn A, 111111011b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 2
	ldr C, B
	cmp C, A
	jzr vytvorKodStvrtyRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 8
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 9
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 10
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 11
	smi 17, D
	jzr nastavCisloKodu

	vytvorKodStvrtyRiadok:
	inn A, 111110111b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 3
	ldr C, B
	cmp C, A
	jzr vytvorKodPrvyRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 12
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 13
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 14
	smi 17, D
	jzr nastavCisloKodu

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 15
	smi 17, D
	jzr nastavCisloKodu
	
	jmp vytvorKodPrvyRiadok

nastavCisloKodu:
	lmi D, 28
	cmi D, 0
	jzr nastavPrveCisloKodu
	lmi D, 29
	cmi D, 0
	jzr nastavDruheCisloKodu
	
nastavPrveCisloKodu:
	mvi D, 1
	smi 28, D
	lmi D, 17
	smi 19, D
	mmr D, D
	out 255, D
	jmp vytvorKodPrvyRiadok

nastavDruheCisloKodu:
	mvi D, 1
	smi 29, D
	lmi D, 17
	smi 20, D
	mmr D, D
	out 383, D
	mvi A, 0
	jmp pomocnyCyklus
	
pomocnyCyklus:
	cmi A, 255
	jzr zakryKod
	inc A
	mvi B, 0
	jmp pomocnyCyklus2

pomocnyCyklus2:
	cmi B, 255
	jzr pomocnyCyklus
	inc B
	mvi C, 0
	jmp pomocnyCyklus3

pomocnyCyklus3:
	cmi C, 5
	jzr pomocnyCyklus2
	inc C
	jmp pomocnyCyklus3
	
;;;;;

zakryKod:
	mvi D, 16
	mmr D, D
	out 255, D
	out 383, D
	jmp inicializaciaPocitadla

inicializaciaPocitadla:
	mvi A,0
	smi 18, A
	jmp prvyRiadok

pocitadloJedna:
	lmi A, 18
	cmi A, 255
	jzr jednotky
	inc A
	smi 18, A
	lmi A, 18
	smi 18, A
	lmi A, 18
	jmp prvyRiadok

jednotky:
	lmi A, 12
	cmi A, 0
	jzr desiatky
	dec A
	smi 12, A
	jmp vypisJednotky
	
desiatky:
	mvi A, 9
	smi 12, A
	lmi A, 11
	cmi A, 0
	jzr stovky
	dec A
	smi 11, A
	jmp vypisDesiatky

stovky:
	mvi A, 9
	smi 11, A
	lmi A, 10
	cmi A, 0
	jzr vybuch
	dec A
	smi 10, A
	jmp vypisStovky

vypisJednotky:
	lmi A, 12
	mmr A, A
	out 495, A
	jmp inicializaciaPocitadla

vypisDesiatky:
	lmi A, 11
	mmr A, A
	out 479, A
	lmi A, 12
	mmr A, A
	out 495, A
	jmp inicializaciaPocitadla

vypisStovky:
	lmi A, 10
	mmr A, A
	out 447, A
	lmi A, 11
	mmr A, A
	out 479, A
	lmi A, 12
	mmr A, A
	out 495, A
	jmp inicializaciaPocitadla
		
prvyRiadok:
	inn A, 111111110b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 0
	ldr C, B
	cmp C, A
	jzr druhyRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 0
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 1
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 2
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 3
	smi 17, D
	jzr vypis


	druhyRiadok:
	inn A, 111111101b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 1
	ldr C, B
	cmp C, A
	jzr tretiRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 4
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 5
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 6
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 7
	smi 17, D
	jzr vypis


	tretiRiadok:
	inn A, 111111011b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 2
	ldr C, B
	cmp C, A
	jzr stvrtyRiadok

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 8
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 9
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 10
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 11
	smi 17, D
	jzr vypis

	stvrtyRiadok:
	inn A, 111110111b
	ani A, 00001111b
	xri A, 1111b

	mvi B, 3
	ldr C, B
	cmp C, A
	jzr pocitadloJedna

	str B, A

	mov B, A
	ani B, 1000b
	cmi B, 1000b
	mvi D, 12
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0100b
	cmi B, 0100b
	mvi D, 13
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0010b
	cmi B, 0010b
	mvi D, 14
	smi 17, D
	jzr vypis

	mov B, A
	ani B, 0001b
	cmi B, 0001b
	mvi D, 15
	smi 17, D
	jzr vypis
	
	
	
	jmp pocitadloJedna

vypis:
	lmi D, 15
	cmi D, 0
	jzr vypisPrvyDisplej
	jmp vypisDruhyDisplej

vypisPrvyDisplej:
	mvi D, 1
	smi 15, D
	lmi D, 17
	smi 21, D
	mmr D, D
	out 255, D
	jmp inicializaciaPocitadla

vypisDruhyDisplej:
	mvi D, 0
	smi 15, D
	lmi D, 17
	smi 22, D
	mmr D, D
	out 383, D
	jmp skontrolujPrvyZnak


pocitadloDva:
	lmi A, 23
	cmi A, 255
	jzr zlyKod
	inc A
	smi 23, A
	lmi A, 23
	jmp pocitadloDva

skontrolujPrvyZnak:
	lmi D, 21
	lmi B, 19
	cmp D, B
	jzr skontrolujDruhe
	jmp pocitadloDva

skontrolujDruhe:
	lmi D, 22
	lmi B, 20
	cmp D, B
	jzr uhadnutyKod
	jmp pocitadloDva

zlyKod:
	mvi A, 0
	smi 23, A
	mvi A, 16
	mmr A, A
	out 383, A
	out 255, A
	jmp jednotky

vybuch:
	mvi A, 00000011b
	out 447, A
	mvi A, 01110001b
	out 479, A
	out 495, A
	jmp koniecHry

uhadnutyKod:
	mvi A, 13
	mmr A, A
	out 447, A
	mvi A, 14
	mmr A, A
	out 479, A
	mvi A, 15
	mmr A, A
	out 495, A
	jmp koniecHry

koniecHry:
