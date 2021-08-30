program procesosArboles;

Uses
     sysutils;

Type

	//Arboles
	Arbol = ^Nodo;
	Nodo = record
		dato: Integer;
		hi: Arbol;
		hd: Arbol;
	end;

	//Lista de Arboles
	lista = ^NodoA;
	NodoA = record
		a: Arbol;
		sig: lista;
	end;

	
	procedure insertar(var a: Arbol; dato: Integer);
	begin
		
		if (a = nil) then begin

			new(a);
			a^.dato:= dato;
			a^.hi:= nil;
			a^.hd:= nil;

		end else begin
			
			if (a^.dato > dato) then begin
				
				insertar(a^.hi, dato);

			end;
			if (a^.dato < dato) then begin
				
				insertar(a^.hd, dato);

			end;

		end;

	end;

	procedure cargarValores(var a: Arbol);
	var
		aux: Integer;
	begin
		
		aux:= random(30);


		while (aux <> 0) do begin

			insertar(a, aux);

			aux:= random(30);

		end;

	end;


	function ContarElementos (l: lista): integer;
	var
		c: Integer;
	begin
		
		c:= 0;

		while (l <> nil) do begin
			
			c:= c + 1;
			l:= l^.sig;

		end;

		contarElementos:= c;

	end;


	Procedure AgregarAtras (var l, ult: lista; a: arbol);
	var 
	 	nue: lista;
	 begin
	 	
	 	new(nue);
	 	nue^.a:= a;
	 	nue^.sig:= nil;

	 	if (l = nil) then begin
	 		
	 		l:= nue;
	 	
	 	end else begin
	 			
	 		ult^.sig:= nue;

	 	end;

	 	ult:= nue;

	 end;


	Procedure imprimirpornivel(a: arbol);
	var
	   l, aux, ult: lista;
	   nivel, cant, i: integer;
	begin
	   	l:= nil;
	   	ult:= nil;

		if (a <> nil ) then begin
			
			nivel:= 0;
			agregarAtras(l, ult, a);

			while (l <> nil) do begin
				
				nivel:= nivel + 1;
				cant:= contarElementos(l);
				write('Nivel ', nivel, ': ');

				for i:= 1 to cant do begin
					
					write(l^.a^.dato, ' - ');

					if (l^.a^.hi <> nil) then begin
						agregarAtras(l, ult, l^.a^.hi);
					end;

					if (l^.a^.hd <> nil) then begin
						agregarAtras(l, ult, l^.a^.hd);
					end;

					aux:= l;
					l:= l^.sig;
					dispose(aux);

				end;

				writeln();

			end;

		end;

	end;

	procedure enOrdenI(a: Arbol);
	begin
		if (a <> nil) then begin
			enOrdenI(a^.hi);
			write(a^.dato, '  ');
			enOrdenI(a^.hd);
		end;
	end;

	procedure enOrdenD(a: Arbol);
	begin
		if (a <> nil) then begin
			enOrdenD(a^.hd);
			write(a^.dato, '  ');
			enOrdenD(a^.hi);
		end;
	end;

	procedure postOrden(a: Arbol);
	begin
		if (a <> nil) then begin
			postOrden(a^.hi);
			postOrden(a^.hd);
			write(a^.dato, '  ');
		end;
	end;

	procedure preOrden(a: Arbol);
	begin
		if (a <> nil) then begin
			write(a^.dato, '  ');
			preOrden(a^.hi);
			preOrden(a^.hd);
		end;
	end;

	function minimo(a: Arbol): Integer;
	begin
		
		

		if (a <> nil) then begin
			
			if (a^.hi = nil) then begin
					
				minimo:= a^.dato;

			end else begin
				
				minimo:= minimo(a^.hi);

			end;

		end else begin
			
			minimo:= -1;

		end;

	end;

	function maximo(a: Arbol): Integer;
	begin

		if (a <> nil) then begin
		
			if (a^.hd = nil) then begin
					
				maximo:= a^.dato;

			end else begin
				
				maximo:= maximo(a^.hd);

			end;

		end else begin
			
			maximo:= -1;

		end;

	end;

	function buscar(a: Arbol; x: Integer): Arbol;
	begin

		if (a <> nil) then begin
			
			if (a^.dato = x) then begin
				
				buscar:= a;

			end else begin
				
				if (a^.dato < x) then begin
					
					buscar:= buscar(a^.hd, x);

				end;

				if (a^.dato > x) then begin
					
					buscar:= buscar(a^.hi, x);

				end;

			end;

		end else begin
			
			buscar:= nil;

		end;	

	end;



	procedure eliminar(var a: Arbol; x: Integer);
	begin
		
		if (a <> nil) then begin

			if (a^.dato > x) then begin
				
				eliminar(a^.hi, x);

			end else begin
				

				if (a^.dato < x) then begin
					
					eliminar(a^.hd, x);

				end else begin
				
					if (a^.hi = nil) then begin
						
						a:= a^.hd;

					end else begin
						
						if (a^.hd = nil) then begin

							a:= a^.hi;

						end else begin
							
							a^.dato:= minimo(a^.hd);
							eliminar(a^.hd, a^.dato);

						end;

					end;

				end;

			end;

		end;

	end;

	procedure busqueda(raiz: arbol);
	var
		x: Integer;
		a, hi, hd: Arbol;	
	begin
		
		readln(x);

		a:= buscar(raiz, x);

		if (a <> nil) then begin
			
			hi:= a^.hi;
			hd:= a^.hd;

			writeln('El elemento esta en la lista:');
			writeln('Dato: ', a^.dato);

			if (hi <> nil) then begin
				
				writeln('Hijo Izquierdo: ', hi^.dato);

			end else begin
				
				writeln('Hijo Izquierdo: nil');

			end;

			if (hd <> nil) then begin
			
				writeln('Hijo Derecho: ', hd^.dato);

			end else begin
				
				writeln('Hijo Derecho: nil');

			end;
			

		end else begin
			
			writeln('El elemento no esta en la lista')

		end;

	end;

	procedure borrar(var raiz: arbol);
	var
		x: Integer;
	begin
		
		readln(x);
		eliminar(raiz, x);
		writeln();
		writeln('Lista actualiza: ');
		writeln();
		imprimirpornivel(raiz);
		writeln();
		writeln('Valores: ');
		enOrdenI(raiz);

	end;


	procedure distribuidor(op: Integer; var raiz: Arbol);
	begin
		
		case op of
			
			0: begin
				writeln('Hasta luego \0/');
			end;

			1: begin
				
				writeln('Cargando valores en el arbol...');
				cargarValores(raiz);
				writeln('Carga completa.');

			end;

			2: begin
				
				writeln('Imprimiendo arbol por nivel...');
				writeln();
				imprimirpornivel(raiz);

			end;

			3: begin
				
				writeln('Imprimiendo arbol en orden creciente...');
				writeln();
				enOrdenI(raiz);

			end;

			4: begin
				
				writeln('Imprimiendo arbol en orden decreciente...');
				writeln();
				enOrdenD(raiz);

			end;

			5: begin 

				writeln('Imprimiendo arbol en post orden...');
				writeln();
				postOrden(raiz);

			end;

			6: begin
				
				writeln('Imprimiendo arbol en pre orden...');
				writeln();
				preOrden(raiz);

			end;

			7: begin
				
				writeln('Minimo valor en el arbol: ', minimo(raiz));

			end;

			8: begin
				
				writeln('Maximo valor en el arbol: ', maximo(raiz));

			end;

			9: begin
				
				writeln('Ingrese el valor que desea buscar: ');
				busqueda(raiz);

			end;

			10: begin
				
				writeln('Ingrese el valor que desea eliminar: ');
				borrar(raiz);

			end

			else begin
				
				writeln('Algo malio sal :O');

			end;

		end;

	end;


	procedure menu(var raiz: Arbol);
	var
		op: Integer;
	begin

		raiz:= nil;
		
		repeat
	
			writeln('--------------Menu--------------');
			writeln('1) Cargar valores en un arbol.');
			writeln('2) Imprimr arbol por nivel.');
			writeln('3) Imprimr arbol en orden creciente (En Orden).');
			writeln('4) Imprimr arbol en orden decreciente (En Orden).');
			writeln('5) Imprimr arbol en post orden.');
			writeln('6) Imprimr arbol pre orden.');
			writeln('7) Imprimr minimo valor en el arbol.');
			writeln('8) Imprimir maximo valor en el arbol.');
			writeln('9) Buscar un valor en el arbol.');
			writeln('10) Eliminar un valor del arbol.');
			writeln('0) Salir.');
			writeln('--------------------------------');
			writeln();

			readln(op);

			writeln();

			distribuidor(op, raiz);

			writeln();

			writeln('Presione enter para continuar');

			readln();

		until (op = 0)

	end;

var
	raiz: Arbol;
	x: Integer;
begin
	randomize;

	menu(raiz);

end.