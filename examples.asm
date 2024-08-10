;orn9 Asm sınavında eşik altı not alanlar kalıyor , eşik üstü not alanların ortalaması alınıp büte girme sınırı belirleniyor, eşik üstü not ortalaması üstündeki öğrenciler dersi geçiyor, altındakiler büte giriyor. Kalan, büte giren ve geçen öürenci sayılarını bulan asm exe tipi kodu yazın
mystack segment para stack 'stc'
		DW 20 DUP (?)
mystack ends

myds	segment para 'veri'
n		dw 280
kalan	dw 0
but		dw 0
succ	dw 0
topnot  dw 0
esik 	db 40
notlar 	db 280 dup(?)
myds	ends
mycs	segment para 'kod'
		assume cs:mycs,ds:myds,ss:mystack
CAN		proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		xor si,si
		mov cx,n
	l3:	mov al,notlar[si]
		cmp al,esik
		jae l1
		inc kalan
		jmp l2
	l1:	cbw
		add topnot,ax
	l2:	inc si
		loop l3
		mov cx,n
		sub cx,kalan
		xor dx,dx
		mov ax,topnot
		div cx ;dx:ax/cx kalan dx, bölüm ax, ort not al
		xor si,si
	l6:	mov ah,notlar[si]
		cmp al,ah
		jbe l4
		cmp ah,esik
		jb l5
		inc but
		jmp l5
	l4: inc succ
	l5: inc si
		loop l6
		retf
CAN 	endp
mycs	ends
		end CAN
		
;orn10 word tanımlı dizide çift/tek değer ortalamasını bulan exe Asm
myss 	segment para stack 'stc'
		DW 20 DUP (?)
myss 	ends

myds	segment para 'veri'
dizi 	dw 10 dup(?)
n		dw 10
tekort	dw 0
tektop	dd 0
cifttop	dd 0
ciftort dw 0
teksay 	dw 0
ciftsay dw 0
myds	ends
mycs	segment para 'kod'
		assume cs:mycs,ds:myds,ss:myss
YORDAM	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		lea si,dizi
		mov cx,n
l3:		mov ax, [si]
		test ax,0001h
		jz l1
		inc teksay
		add word ptr [tektop],ax
		adc word ptr [tektop+2],0
		jmp l2
l1:		inc ciftsay
		add word ptr [cifttop],ax
		adc word ptr [cifttop+2],0
l2:		add si,2
		loop l3
		mov dx,word ptr[cifttop+2]
		mov ax,word ptr[cifttop]
		div ciftsay
		mov dx, word ptr[tektop+2]
		mov ax, word ptr[tektop]
		div teksay
		retf
YORDAM	endp
mycs	ends
		end YORDAM


;orn11  verilen kucukten buyuge sıralı iki diziyi yine aynı şekilde sıralı d3 dizisiyle birlestiren asm exe codu
myss	segment para stack 'stc'
		dw 20 dup(?)
myss	ends

myds	segment para stack 'veri'
n1		dw 4
n2		dw 6
d1		db 4 dup(?)
d2		db 6 dup(?)
d3		db 12 dup(?)
myds	ends

mycs	segment para 'kod'
		assume cs:mycs,ds:myds,ss:myss
ANA		proc far		
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		xor bx,bx
		xor si,si
		xor di,di
l4:		cmp bx,n1
		jae l1
		cmp si,n2
		jae l1
		mov al,d1[bx]
		mov ah,d2[si]
		cmp al,ah
		jl l2
		mov d3[di],ah
		inc si
		jmp l3
l2:		mov d3[di],al
		inc bx
l3:		inc di
		jmp l4
l1:		cmp si,n2
		je l5
		mov cx,n2
		sub cx,si
l6:		mov al,d2[si]
		mov d3[di],al
		inc si
		inc di
		loop l6
		jmp l7
l5:		mov cx,n1
		sub cx,bx
l8		mov al,d1[bx]
		mov d3[di],al
		inc bx
		inc di
		loop l8
l7:		retf
ANA		endp
mycs 	ends
		end ANA
		
;orn11 yıllık sıcaklık dizisinde -20 altında sıcaklık olup olmadığını bulan com tipi codu
codesg	segment para 'kod'
		org 100h
		assume cs:codesg, ds:codesg, ss:codesg
basla: 	jmp TEMP
n		dw 365
dizi	db 365 dub (?)
esik 	db -20
sonuc	db 0
TEMP	proc near
		xor si,si
		mov cx,n
		mov al,esik
l3:		cmp si,cx
		jae l1
		cmp al,dizi[si]
		jg l2
		inc si
		jmp l3
l1:		ret
TEMP	endp
codesg	ends
		end basla
		
;orn13 yasları 15ten küçük, 50den büyük 10 kişi dizisinde koşulu bozan 11. kişiyi bulan com codu
mycode 	segment para 'kod'
		org 100h
		assume cs:mycode,ds:mycode,ss:mycode
start:	jmp kaynak
kesik	db 15
besik	db 50
dizi	db 11,14,5,55,43,80,2,6,9,65,12
sonuc	db ?
kaynak	proc near
		xor bx,bx
		mov al kesik
		mov ah besik
l3:		cmp dizi[bx],al
		jae l1
		cmp dizi[bx],ah
		jbe l1
		inc bx
		jmp l3
l1:		mov sonuc, bl
		ret
kaynak	endp
mycode	ends
		end start

;orn14 sayı ve üst değerini ana yordamdan USTAL yordamına yollayan ana programı ve ustal yordamını exe tipinde yazın
myss	segment para stack'stc'
		dw 20 dup (?)
myss	ends

myds	segment para 'veri'
sayi	dw 2
ust 	dw 10
sonuc	DW ?
myds	ends

mycs	segment para 'code'
		assume cs:mycs,ds:myds,ss:myss
ANA		proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		mov bx,sayi
		mov cx,ust
		CALL USTAL
		mov sonuc,ax
		retf
ANA 	endp

USTAL	proc near
		mov ax,1
l1:		mul bx
		loop l1
		ret
USTAL	endp
mycs	ends
		end ANA
;orn15 bl ve bh üzerinden iki değer toplayan ve ax üzerinden sonucu döndüren harici yordamı ve bu harici yordamı cağıran ana yordamı exe tipinde yazın

		extrn TOPLAMA: far
myss	segment para stack 'yigin'
		dw 20 dup(?)
myss	ends

myds	segment para 'veri'
sayi1 	db 17
sayi2	db 29
sonuc	dw ?
myds	ends

mycs	segment para 'kod'
		assume cs:mycs,ds:myds,ss:myss
ANA		proc far
		push ds
		xor ax,ax
		push ax
		mov ax, myds
		mov ds,ax
		mov bl,sayi1
		mov bh,sayi2
		call TOPLAMA
		mov sonuc,ax
		retf
ANA		endp
mycs	ends
		end ANA
		
mycode	segment para 'code'
		assume cs:mycode
TOPLAMA	proc near
		xor ax,ax
		mov al,bl
		add al,bh
		adc ah,0
		retf
TOPLAMA	endp
mycode	ends
		end
		
;orn16 ardısık 3 elemanın ucgen kenari oldugu dizide n tane ucgenin kenarları tutulmaktadır. ucgen kenarlarını stack uzerinden alan ve bu ucgenın alanlarının karesını ax uzerinden donduren harici yordamla en buyuk alanı bulan ana exe codları

myss	segment para stack 'yigin'
		dw 20 dup(?)
myss	ends

myds	segment para 'veri'
edges	dw 6,8,10,9,4,8,2,2,2
n		dw 3
maxarea	dw 0
myds 	ends

mycs	segment para 'kod'
		assume cs:mycs,ds:myds,ss:myss
ANA		proc far
		push ds
		xor ax,ax
		mov ax,myds
		mov ds,ax
		mov cx,n
		xor si,si
l2:		push edges[si]
		push edges[si+2]
		push edges[si+4]
		call ALANBUL ;we can add pop bx 3 times? instead of retf6 in mycode segment
		cmp ax,maxarea
		jb l1
		mov maxarea,ax
		add si,6
		loop l2
		retf
ANA		endp
mycs	ends
		end ANA
		
		
mycode	segment para 'code'
		assume cs:mycode
ALANBUL	proc far
		push bx
		push cx
		push di
		push bp
		push dx
		mov bp,sp
		xor ax,ax
		add ax,[bp+14]
		add ax,[bp+16]
		add ax,[bp+18]
		shr ax,1
		mov bx,ax
		sub bx,[bp+14]
		mov cx,ax
		sub cx,[bp,16]
		mov di,ax
		sub di,[bp+18]
		mul bx
		mul cx
		mul di
		pop dx
		pop bp
		pop di
		pop cx
		pop bx
		retf 6
		
		
;orn17 verilen dizinin kucukten buyuge sıralı olup olmadığını bulan harıcı yordamı yazın. yordam verilere extrn ve public komutlarıyla erismeli. sonuc alde tutulsun
EXTRN ORDER far 
PUBLIC n,dizi

myss	segment para stack 'yıgın'
		dw 20 dup(?)
myss 	ends

myds	segment para 'veri'
n		dw 7
dizi	db 12,14,18,16,20,22,23,24
s		db 0
myds 	ends

mycs	segment para 'code'
		assume cs:mycs,ds:myds,ss:myss
ANA 	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		call ORDER
		cmp al,0
		jz l1
		mov s,1
l1:		retf
ANA		endp
mycs	ends
		end ANA


PUBLIC ORDER
EXTRN dizi:BYTE n:word
		
mycode	segment para 'kod'
		assume cs:mycode
ORDER	proc far
		xor al,al
		xor si,si
		mov cx,n
		dec cx
l3:		cmp si,cx
		jae l1
		mov ah, dizi[si]
		cmp ah,dizi[si+1]
		jg l2
		inc si
		jmp l3
l2:		mov s,1
l1:		ret
ORDER	endp
mycode 	ends
		end ORDER
		
;orn18 300 elemanlı word tanımlı dizi icinde verilen byte tanımlı bir degerin kaç kere geçtiğini bulan exe tipi programı yazın.
;dizi adresini, eleman sayısını, istenen değeri ana yordam stackte tutup SAY isimli yardımcı yordamı cagırarak ax uzerinden degeri alacak. aynı cs uzerinden
EXTRN SAY: far
myss	segment para stack 'yigin'
		dw 20 dup(?)
myss	ends

myds	segment para 'veri'
n		dw 300
aranan	db 5
dizi	dw 300 dup(?)
sonuc	dw 0
myds	ends

mycs	segment para 'kod'
		assume cs:mycs,ds:myds,ss:myss
MAIN	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		mov cx,n
		lea si,dizi
		push cx
		push si
		xor ax,ax
		mov al,aranan
		push ax
		call SAY
		mov sonuc,ax
		pop bx
		pop bx
		pop bx
		retf
MAIN	endp
mycs	ends
		end MAIN

		public SAY
mycs1 	segment para 
		assume cs:mycs1
SAY		proc far
		push cx
		push si
		push bp
		push bx
		mov bp,sp
		mov cx,[bp+16]
		mov si,[bp+14]
		mov bx,[bp+12]
l2:		cmp bx,[si]
		jne l1
		inc bx
l1:		add si,2
		loop l2
		
		mov ax,bx
		pop bx
		pop bp
		pop si
		pop cx
		retf
SAY		endp
mycs1	ends
		end
		
		
;orn20 1,3,5	... tek sayılar çıkartılarak sonuc negatif olana kadar yapilan islem sayisi sayinin karekokunu verir.
;yigindan parametre alıp sonucu yigindan dönen sqroot isimli harici yodam ve main yordamını exe tipinde yazın
		extrn SQROOT:far
myss	segment para stack 'yigin'
		dw 20 dup(?)
myss	ends

myds	segment para 'veri'

sayi	DW	525
sonuc	dw ?

myds	ends

mycs	segment para 'kod'
		assume cs:mycs, ds:myds, ss:myss
MAIN	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		push sayi
		call SQROOT 
		pop ax
		mov sonuc,ax
		retf
MAIN	endp
mycs	ends
		end MAIN
		
		
		PUBLIC SQROOT
mycode	segment para 'code'
		assume cs:mycode
SQROOT	proc far
		push ax
		push bx
		push cx
		push bp
		mov bp,sp
		mov ax,[bp+12]
		mov bx,1
		xor cx,cx
l2:		sub ax,bx
		cmp ax,0
		jle l1
		inc cx
		add bx,2
		jmp l2
l1:		mov [bp+12],cx
		pop bp
		pop cx
		pop bx
		pop ax
		retf
		
SQROOT	endp
mycode	ends
		end
		

;orn21 pozitif ve negatif sayılardan olusan 5 elemanlı word tanımlı bir dizinin elemanlarının binary gosterimindeki 1'leri sayan ve
;o elemanı 1'lerin sayısına bolen exe tipi programı yaz. Ana yordam sırasıyla dizinin her bir elemanını stack'e atsın ve SAYBOL yordamını cagırsın
;sonucu yordam ax uzerinden dondursun
		extrn SAYBOL:far
myss	segment para stack 'yigin'
		dw 20 dup(?)
myss	ends

myds	segment para 'veri'
n		dw 5
dizi	dw 5 dup(?)

myds	ends

mycs	segment para public 'kod'
		assume cs:mycs,ds:myds,ss:myss
MAIN	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		mov cx,n
		xor si,si
l1:		mov bx,dizi[si]
		push bx
		CALL SAYBOL
		mov dizi[si],ax
		add si,2
		pop bx
		loop l1
		retf
MAIN	endp
mycs	ends
		end MAIN
		
		
		PUBLIC SAYBOL
mycode	segment public para 'kod'
		assume cs:mycode
SAYBOL	proc far
		
		push cx
		push bx
		push dx
		push bp
		mov bp,sp
		
		mov cx,16
		xor bx,bx
		mov ax,[bp+12]
		cmp ax,0
		jz l1
	l2:	shr ax,1
		adc bx,0
		loop l2
		mov ax,[bp+12]
		cwd
		IDIV bx
		;mov [bp+12],ax ::stack uzerinden dondurmek icin?
	l1:	pop bp
		pop dx
		pop bx
		pop cx
		
		retf
SAYBOL	endp
mycode	ends
		end
		
		
		


		
;Üç boyutlu uzayda vektörel çarpım işlemi herhangi A=(a,b,c) ve B=(u,v,w) 
;vektörleri için aşağıdaki şekilde tanımlanır.
;A×B=(bw-cv,cu-aw,av-bu)
;Bir girdi vektörü, herbiri işaretli, byte büyüklüğünde 3 adet sayıdan 
;oluşur. Buna göre A ve B vektörlerini yığın üzerinden alan, verilen formüle 
;göre vektörel çarpımını hesaplayan ve sonucu yine yığın üzerinden döndüren 
;VECTOR_MUL isimli harici yordamını yazınız.(%30)
;NOT: Yordamı yazarken kesinlikle veri alanı tanımı yapmayınız.


;900 elemanlı, byte büyüklüğünde, işaretli elemanları olan DIZIA ve DIZIB
;isimli vektör dizilerinin karşılıklı (aynı indisli) elemanları için 
;vektörel çarpımı VECTOR_MUL isimli harici yordam yardımıyla hesaplayıp, 
;işlem sonucunda dönen değerlerin kaç tanesinin herhangi bir eksen üzerinde 
;olduğunu bulan ve OVERXYZ isimli değişkende saklayan assembly programı
;yazınız. (%25)
;NOT: Soru 3 de tarif edildiği gibi VECTOR_MUL isimli harici yordamı, 
;parametreleri yığın üzerinden alır ve sonucu yığın üzerinden döndürür. 
;Vektör değeri dizilerin birbirini takip eden üç elemanıdır. Dönen 
;değerlerden en az biri 0 (sıfır) ise eksen üzerinde olduğu anlaşılır. 
		extrn VECTOR_MUL:far
myss	segment para stack 'yigin'
		dw 20 dup(?)
myss	ends

myds	segment para 'veri'
n		dw 900
DIZIA	db 900 dup(?)
DIZIB	db 900 dup(?)
OVERXYZ	dw 0

myds	ends
mycs	segment	para public 'kod'
		assume	cs:mycs,ds:myds,ss:myss
MAIN	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		mov cx,n
		xor si,si
		xor di,di
	l4:	mov al,DIZIA[si]
		mov ah,DIZIB[si]
		push ax		
		
		mov al,DIZIA[si+1]
		mov ah,DIZIB[si+1]
		push ax		
		
		mov al,DIZIA[si+2]
		mov ah,DIZIB[si+2]
		push ax
		
		CALL VECTOR_MUL
		mov bp,sp
		mov bx,3
	l2:	cmp [bp],0
		jz l1
		inc bp
		dec	bx
		cmp bx,0
		jnz l2
		jmp l3
	l1: inc di
	l3:	pop dx
		pop dx
		pop dx
		add si,3
		loop l4
		
		mov OVERXYZ,di
		
MAIN	endp
mycs	ends
		end MAIN
		
		
		
		


		PUBLIC VECTOR_MUL
mycode	segment para public 'kod'
		assume cs:mycode
VECTOR_MUL	proc far
		push ax
		push bx
		push cx
		push dx
		push si
		push di
		push bp
		mov bp,sp
		xor ax,ax
		
		mov al,[bp+22] 	;b
		cbw
		mov bx,ax
		xor ax,ax
		mov al[bp+18] 	;w
		cbw
		xchg ax,bx
		imul bx
		mov si,ax		;si=bw
		
		mov al,[bp+21]	;c
		cbw
		mov bx,ax
		xor ax,ax
		mov al[bp+19]	;v
		cbw
		xchg ax,bx
		imul bx
		sub si,ax  		;AxB(1,x,x):si=bw-cv
		
		mov al,[bp+21]	;c
		cbw
		mov bx,ax
		xor ax,ax
		mov al[bp+20]	;u
		cbw
		xchg ax,bx
		imul bx			
		mov di,ax		;di=cu
		
		mov al,[bp+23]	;a
		cbw
		mov bx,ax
		xor ax,ax
		mov al[bp+18]	;w
		cbw
		xchg ax,bx
		imul bx
		sub di,ax		;AxB(x,2,x):di=cu-aw

		mov al,[bp+23]	;a
		cbw
		mov bx,ax
		xor ax,ax
		mov al[bp+19]	;v
		cbw
		xchg ax,bx
		imul bx
		mov cx,ax		;cx=av
		
		mov al,[bp+22]	;b
		cbw
		mov bx,ax
		xor ax,ax
		mov al[bp+20]	;u
		cbw
		xchg ax,bx
		imul bx
		sub cx,ax		;AxB(x,x,3):cx=av-bu
		
		mov [bp+22],si
		mov [bp+20],di
		mov [bp+18],cx
		
		pop bp
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		retf
VECTOR_MUL	endp
mycode	ends
		end
		
		
;orn_extra 
;Write an assembly language program in EXE format that takes an array of 20 signed bytes and calculates the sum of the positive numbers and the sum of the negative numbers separately. 
;The results should be stored in the data segment variables sum_positive and sum_negative. Use a subroutine named CALC_SUMS to perform the calculations. 
;The main program should initialize the data and call the subroutine. Assume the array is already defined and filled with values.
myss	segment para stack 'yigin'
		dw 20 dup (?)
myss	ends

myds	segment para 'veri'
n		dw 20
array	db	20 dup (?)
sum_p	dw 0
sum_n  	dw 0

myds	ends

mycs	segment para 'code'
		assume cs:mycs,ds:myds,ss:myss
MAIN	proc far
		push ds
		xor ax,ax
		push ax
		mov ax,myds
		mov ds,ax
		lea si,array
		CALL SUMS
		mov sum_p,di
		mov sum_n,bx
		
		retf
MAIN	endp

SUMS	proc near
		xor ax,ax
		xor bx,bx
		xor di,di
		mov cx,n
	l3:	mov al,[si]
		cbw
		cmp ax,0
		jl l1
		add di,ax
		jmp l2
	l1:	add bx,ax
	l2:	inc si
		loop l3
		ret
SUMS	endp

mycs	ends
		end MAIN
		
		
;Implement an assembly subroutine to generate the first n terms of the Fibonacci sequence. 
;Pass the value of n as a parameter and return the sequence using the stack. 
;Optimize the subroutine for performance.
		PUBLIC FIBBO 
mycode 	segment para public 'code'
		assume cs:mycode
FIBBO	proc far
		push ax
		push bx
		push di
		push bp
		mov bp,sp
		mov ax,1
		mov bx,0
		mov cx,[bp+12]
		mov di,ax
		add ax,bx
		mov bx,di
		loop l4:
		mov [bp+12],ax
		pop bp
		pop di
		pop bx
		pop ax
		retf
FIBBO	endp
mycode 	ends
		end
		

		
		
		
		
		



		
		

		
		
		
		
		
		
		
		
		
		

		
		
		
		
		
		


	