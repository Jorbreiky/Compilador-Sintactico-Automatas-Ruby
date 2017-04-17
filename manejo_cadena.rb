class ManejoCadena

  def esDigito (simbolo)
    return simbolo.match(/^[0-9]/)
  end

  def esPunto(simbolo)
    return simbolo.match(/[.]/)
  end

  def esExponente(simbolo)
    return simbolo.match(/[\^]/)
  end

  def esE(simbolo)
    return simbolo.match(/[eE]/)
  end

  def esSignoMasMenos(simbolo)
    simbolo = simbolo.to_s
    if(simbolo.match(/[-+]/))
      return true
    else
      return false
    end
  end

  def esSignoPorEntre(simbolo)
    if(simbolo.match(/[*]/))
      return true
    elsif simbolo.match(/[\/]/)
      return true
    elsif simbolo.match(/[%]/)
      return true
    elsif simbolo.match(/[&]/)
      return true
      elsif simbolo.match(/[\|]/)
    else
      return false
    end
  end

  def signosTermino(simbolo)
    return simbolo.match(/[*\/%&|D]/)
  end

  def esLetra(simbolo)
    return simbolo =~/^[a-zA-Z]/
  end

  def esOperador(simbolo)
    if(simbolo.match(/^[+]/))
      return true
    elsif(simbolo.match(/^[-]/))
      return true
    elsif(simbolo.match(/^[*]/))
      return true
    elsif(simbolo.match(/^[\/]/))
      return true
    else
      return false
    end
  end

  def esOperadorLogico(simbolo)
    if(simbolo.match(/==/))
      return true
    elsif(simbolo.match(/!=/))
      return true
    elsif(simbolo.match(/[<]/))
      return true
    elsif(simbolo.match(/[>]/))
      return true
    elsif(simbolo.match(/[>=]/))
      return true
    elsif(simbolo.match(/[<=]/))
      return true
    else
      return false
    end
  end

  def esIgual(simbolo)
    return simbolo =~/^[=]/
  end

  def esDosPuntosIgual(cadena)
    if cadena.match(/:=/)
      return true
    else
      return false
    end
  end

  def esFDC(simbolo)
    return simbolo =~ /\$/
  end

  def esParentesis1(simbolo)
    return simbolo.match(/[(]/)
  end

  def esParentesis2(simbolo)
    return simbolo.match(/[)]/)
  end

  def separarExpresion(cadena)
    cadena = cadena.gsub(" ","")
    separador = Array.new
    token = obtenerParentesisTermino(cadena)
    token.each { |simbolo|
      if(simbolo.match(/[(].+[)]/))
        separador.push(simbolo)
      else
        simbolo = simbolo.gsub(/[+]/," + ")
        simbolo = simbolo.gsub(/[-]/," - ")
        a = simbolo.split(" ")
        separador.push(a)
      end
    }

    separador = separador.join(" ")
    separador = separador.split(" ")
    return separador
  end

  def separarCadena(cadena)
    cadena = cadena.gsub("\t","")
    array = cadena.split("\n")
    lineas = Array.new
    array.each{|linea|
      if linea.match(/[.]$/)
        linea = linea.sub(/[.]$/,"\n.")
        lineas.push(linea)
      else
        lineas.push(linea)
      end
    }
    cadena = lineas.join("\n")
    array = cadena.split("\n")
    cadena = Array.new
    contadorCadena=0
    i=0

    begin
    while i<array.length
      contenido = array[i]

      if contenido.match(/^const|^var|^procedure/)
        cadena.push(contenido)
        contadorCadena+=1
      elsif contenido.match(/^begin.*end$/)
        cadena.push(contenido)
      elsif contenido.match(/^begin/)
        nuevoBegin = encontrarEnd(array,i+1)
        i=nuevoBegin[1]
        cadena.push(contenido+" "+nuevoBegin[0])
        contadorCadena +=1
      elsif contenido.match(/^call|^if|^while|.*:=.*/)
        cadena.push(contenido)
        contadorCadena +=1
      else
        cadena.push(contenido)
        contadorCadena+=1
      end
      i+=1
    end

    return cadena

    rescue Exception => e
      puts "Excepcion: #{e.message.to_s}"
    end

  end
#***************************************************************
  def encontrarEnd(array,i)
    cadena = Array.new
    j=i
    begin
    while j<array.length
      contenido = array[j]
      if contenido.match(/^begin/)
        nuevoBegin = encontrarEnd(array,j+1)
        j = nuevoBegin[1]
        cadena.push(contenido.to_s+" "+nuevoBegin[0].to_s)
      elsif contenido.match(/end/)
        if j==i
          return c = [cadena,j]
        else
          cadena.push(contenido)
          cadena = cadena.join(" ")
          return c = [cadena,j]
        end
      else
        cadena.push(contenido)
      end
      j+=1
    end
    rescue Exception => e
      puts "EXCEPCION  2"+ e.message.to_s
      return c = [cadena,j]
    end

  end
#***************************************************************
  def separarCondicion(cadena)
    cadena = cadena.gsub(" ","")
    cadena = cadena.gsub(/odd/," odd ")
    cadena = cadena.gsub(/==/," == ")
    cadena = cadena.gsub(/!=/," != ")
    cadena = cadena.gsub(/>/," > ")
    cadena = cadena.gsub(/</," < ")
    cadena = cadena.gsub(/[<]\s*[=]/," <= ")
    cadena = cadena.gsub(/[>]\s*[=]/," >= ")
    return cadena.split(" ")

  end

  def separarBloque(cadena)
    cadena = cadena.gsub(" ","")
    cadena = cadena.gsub(/const/," const ")
    cadena = cadena.gsub(/var/," var ")
    cadena = cadena.gsub(/procedure/," procedure ")
    cadena = cadena.gsub(/[=]/," = ")
    cadena = cadena.gsub(/[;]/," ; ")
    cadena = cadena.gsub(/[,]/," , ")
    return cadena.split(" ")

  end

  def separarInstruccion(cadena)
    cadena = cadena.gsub(" ","")
    if cadena.match(/call.*/)
      cadena = cadena.sub(/call/," call ")
    elsif cadena.match(/^begin/)
      return separarComasBegin(cadena)
    elsif cadena.match(/^if.*then.*/)
      cadena = cadena.sub(/if/," if ")
      cadena = cadena.sub(/then/," then ")
    elsif cadena.match(/^while.*do.*/)
      cadena = cadena.sub(/while/," while ")
      cadena = cadena.sub(/do/," do ")
    else
      cadena = cadena.sub(/:=/," := ")
    end
    return cadena.split(" ")

  end

  def separarComasBegin(cadena)

    arregloSeparado = Array.new

    if cadena.match(/^begin/)
      cadena = cadena.sub("begin","begin°")
      if cadena.match(/end[.]$/)
        cadena =cadena.sub(/end[.]$/, "°end°.")
      elsif cadena.match(/end$/)
      cadena = cadena.sub("end","°end")
      end

    if cadena.match(/.*begin.*end/)
      cadena = cadena.gsub(/begin/,"°begin")
      cadena = cadena.gsub(/end/,"end°")
    end
    end
    array = cadena.split("°")


    for i in 0..array.length-1
      if array[i]!=""
        if array[i].match(/^begin.*end$/)
          arregloSeparado.push(array[i])
        elsif array[i].match(/^begin|^end/)
          array[i] = array[i].gsub("begin","begin°")
          array[i] = array[i].gsub("end","°end°")
          arregloSeparado.push(array[i])
        elsif
          array[i] = array[i].gsub(";","°;°")
          arregloSeparado.push(array[i])
        end
      end
    end

    aux = arregloSeparado.join("")
    arregloSeparado = aux.split("°")

    return arregloSeparado

  end

  def separarTermino(cadena)
    separador = Array.new
    token = obtenerParentesisTermino(cadena)
    token.each { |simbolo|

      if(simbolo.match(/[(].+[)]/))
        separador.push(simbolo)
      else
        simbolo = simbolo.gsub(/[*]/," * ")
        simbolo = simbolo.gsub(/[\/]/," / ")
        simbolo = simbolo.gsub(/[&]/," & ")
        simbolo = simbolo.gsub(/[D]/," D ")
        simbolo = simbolo.gsub(/[%]/," % ")
        a = simbolo.split(" ")
        separador.push(a)
      end
    }
    separador = separador.join(" ")
    separador = separador.split(" ")
    return separador
  end

  def separarParentesis(cadena)
    cadena = cadena.gsub(" ","")
    cadena = cadena.gsub(/[(]/," ( ")
    cadena = cadena.gsub(/[)]/," ) ")
    return cadena.split(" ")
  end

  def contieneParentesis(cadena)
    if cadena.match(/([(].+[)])/)
      return true
    else
      false
    end
  end

  def obtenerParentesisExpresion(cadena)
    cadena = cadena.gsub("("," (")
    cadena = cadena.gsub(")",") ")
    return cadena.split(" ")
  end

  def obtenerParentesisTermino(cadena)
    cadena = cadena.gsub("("," (")
    cadena = cadena.gsub(")",") ")
    return cadena.split(" ")
  end

  def esODD(cadena)
    if cadena.match(/odd/)
      return true
    else
      return false
    end
  end

  def esConst(cadena)
    if cadena.match(/const/)
      return true
    else
      return false
    end
  end

  def esVar(cadena)
    if cadena.match(/var/)
      return true
    else
      return false
    end
  end

  def esProcedure(cadena)
    if cadena.match(/procedure/)
      return true
    else
      return false
    end
  end

  def esCall(cadena)
    if cadena.match(/call/)
      return true
    else
      return false
    end
  end

  def esBegin(cadena)
    if cadena.match(/begin/)
      return true
    else
      return false
    end
  end

  def esIf(cadena)
    if cadena.match(/if/)
      return true
    else
      return false
    end
  end

  def esWhile(cadena)
    if cadena.match(/while/)
      return true
    else
      return false
    end
  end

  def esComa(cadena)
    if cadena.match(/,/)
      return true
    else
      return false
    end
  end

  def esPuntoYComa(cadena)
    if cadena.match(/;/)
      return true
    else
      return false
    end
  end

  def esEnd(cadena)
    if cadena.match(/end/)
      return true
    else
      return false
    end
  end

  def esThen(cadena)
    if cadena.match(/then/)
      return true
    else
      return false
    end
  end

  def esDo(cadena)
    if cadena.match(/do/)
      return true
    else
      return false
    end
  end

end
=begin
=end