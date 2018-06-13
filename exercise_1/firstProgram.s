# dyrektywa .equ nadaje etykiety stale (odpowiednik #define z C)
 .equ kernel,0x80 #Adres przerwania dla Kernela w Linux
 .equ write,0x04 #Numer funkcji pisania na ekranie
 .equ exit,0x01 #Kod wyjścia z programu
 .data # dyrektywa ustalajaca ze od tego miejsca mamy dane

starttxt: #first message
 .ascii "Start\n" # umieszcza w pamieci tekst podany w cudzysłowiach
endtxt: #second message
 .ascii "Koniec, a w zasadzie dopiero poczatek, bo pierwszy lab\n"
.equ startlen, endtxt - starttxt
 # ustalamy długość tekstu "start" do tego celu używamy etykiety
.equ endlen, . - endtxt
 # długość tekstu "Koniec", wykorzystujemy kropkę, która zwraca
 # nam adres pamięci w tym miejscu programu
 .text # kod programu w postaci tekstu

 # .global okresla ze symbol ma byc globalny (ważne dla kompilatora i linkera!! )
 .global _start

_start:
 # ustalamy jaka funkcja bedzie uzywana, w tym wypadku pisanie
 MOVL $write,%eax
 # ustalamy gdzie chcemy pisać, w naszym wypadku na standardowe wyjście
 MOVL $1,%ebx
 # Możliwe tryby to:
 # 0 stdin
 # 1 stdout
 # 2 stderr

 # przekazanie tekstu, który chcemy wypisać
 MOVL $starttxt,%ecx

 # przekazujemy dlugość wypisywanego ciągu znaków
 MOVL $startlen,%edx

 # przerwanie do systemu przerwania
 INT $kernel
 NOP


 # to samo dla drugiego napisu
 MOVL $write,%eax
 MOVL $1,%ebx
 MOVL $endtxt,%ecx
 MOVL $endlen,%edx
 INT $kernel
 NOP
theend:
 MOVL $exit,%eax # przekazanie funkcji końca programu do systemu
 INT $kernel # przerwanie i koniec programu