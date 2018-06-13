#argumenty funkcji w programach 64-bitowych wrzucane są kolejno do rejestrów: RDI, RSI, RDX, RCX, R8, R9 - gdyby ich było więcej to poszłyby na stos, ale na kolokwium tak się raczej nie zdarzy

# long max_diff(long a, long b, long c, long d);
#nagłówki takie jak zawsze
	.text
	.type max_diff, @function
	.global max_diff
	
max_diff: #tu sie zaczyna nasza funkcja, najpierw zamierzam wyznaczyć największy argument i wrzucić go do rejestru rax
	push %rdi #wrzucam na stos rdi, ponieważ zamierzam przenosić do tego rejestru różne wartości, a nie chcemy zgubić wartości pierwszego argumentu
	
	cmp %rdi,%rsi #sprawdzam jak się ma pierwszy argument do drugiego
	jle compare2  #gdyby to było C, to napisałbym if(rsi > rdi) mov(rsi,rdi), ale tutaj chcemy OMINĄĆ mov jeśli zajdzie warunek, czyli musimy wpisać warunek odwrotny, czyli zamiast > piszemy<=,właśnie 			      
#to znaczy jle: jump if less or equal (TYLKO DLA ZMIENNYCH ZE ZNAKIEM, UNSIGNED INACZEJ!)
	mov %rsi,%rdi #przenosimy...
compare2:
	cmp %rdi,%rdx #jak wyżej, tylko sprawdzamy dla trzeciego argumentu
	jle compare3
	mov %rdx,%rdi
compare3:
	cmp %rdi,%rcx #jak wyżej, tylko sprawdzamy dla czwartego argumentu
	jle cmpmin
	mov %rcx,%rdi
	
cmpmin:
	mov %rdi,%rax #kopiuję wartość największego argumentu do rax, przyda nam się później
	pop %rdi #zdejmuję wartość ze stosu i umieszczam ją w rdi, ostatnią rzeczą jaka znalazła się na stosie była wartość pierwszego argumentu i właśnie ją dostajemy. dzięki temu w rdi znowu mamy pierwszy argument, tak jak na początku funkcji
	
	cmp %rdi,%rsi #tutaj wszystko tak jak wyżej, tylko szukamy najmniejszego argumentu, czyli nie używamy jle tylko jge (jump if greater or equal)
	jge compare4
	mov %rsi,%rdi
compare4:
	cmp %rdi,%rdx
	jge compare5
	mov %rdx,%rdi
compare5:
	cmp %rdi,%rcx
	jge result
	mov %rcx,%rdi
	
result:
	sub %rdi,%rax #odejmuję od wartości w rax wartość w rdi i umieszczam ją z powrotem w rax, czyli inaczej: rax=rax-rdi. czemu rax? bo przez ten rejestr zwracamy wartość
	ret #powrót z funkcji
