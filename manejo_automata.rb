require_relative 'automata.rb'
require_relative 'automata_expresion.rb'
require_relative 'automata_factor.rb'
require_relative 'automata_numero.rb'
require_relative 'automata_termino.rb'
require_relative 'automata_identificador.rb'
require_relative 'manejo_cadena.rb'
require_relative 'manejo_automata.rb'
require_relative 'automata_condicion.rb'
require_relative 'automata_bloque.rb'
require_relative 'automata_instruccion.rb'
require_relative 'manejo_errores.rb'

class ManejoAutomata

  def esNumero(cadena)
    estado = 1
    automataNumero = AutomataNumero.new(estado)
    cadena.each_char{|simbolo|
      estado = automataNumero.transicion(simbolo)

      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    return automataNumero.esFinal(estado)
  end

  def numero(cadena)
    estado = 1
    automataNumero = AutomataNumero.new(estado)
    cadena.each_char{|simbolo|
      estado = automataNumero.transicion(simbolo)

      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }

    if automataNumero.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end
  end

  def esIdentificador(cadena)
    estado = 1
    automataIdentificador = AutomataIdentificador.new(estado)
    cadena.each_char{|simbolo|
      estado = automataIdentificador.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    return automataIdentificador.esFinal(estado)

  end

  def identificador(cadena)
    estado = 1
    automataIdentificador = AutomataIdentificador.new(estado)
    cadena.each_char{|simbolo|
      estado = automataIdentificador.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    if automataIdentificador.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end

  end

  def esFactor(cadena)
    tokens = ManejoCadena.new.separarParentesis(cadena)
    tokens.delete("")
    estado = 1
    automataFactor = AutomataFactor.new(estado)
    tokens.each { |simbolo|
      estado = automataFactor.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    automataFactor.esFinal(estado)
  end

  def factor(cadena)
    tokens = ManejoCadena.new.separarParentesis(cadena)
    estado = 1
    tokens.delete("")
    automataFactor = AutomataFactor.new(estado)
    tokens.each { |simbolo|
      estado = automataFactor.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    if automataFactor.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end
  end

  def esTermino(cadena)
    load 'manejo_cadena.rb'
    load 'automata_termino.rb'
    estado = 1
    termino = AutomataTermino.new(estado)
    tokens = ManejoCadena.new.separarTermino(cadena)
    tokens.delete("")
    tokens.each{|simbolo|
      estado = termino.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    return termino.esFinal(estado)
  end

  def termino(cadena)
    load 'manejo_cadena.rb'
    load 'automata_termino.rb'
    estado = 1
    termino = AutomataTermino.new(estado)
    tokens = ManejoCadena.new.separarTermino(cadena)
    tokens.delete("")
    tokens.each{|simbolo|
      estado = termino.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    if termino.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end
  end

  def esExpresion(cadena)
    load 'automata_expresion.rb'
    estado = 1
    expresion = AutomataExpresion.new(estado)
    tokens = ManejoCadena.new.separarExpresion(cadena)
    tokens.delete("")
    tokens.each{|simbolo|
      estado = expresion.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    return expresion.esFinal(estado)
  end

  def expresion(cadena)
    load 'automata_expresion.rb'
    estado = 1
    expresion = AutomataExpresion.new(estado)
    tokens = ManejoCadena.new.separarExpresion(cadena)
    tokens.delete("")
    tokens.each{|simbolo|
      estado = expresion.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    if expresion.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end
  end

  def esCondicion(cadena)
    load 'automata_termino.rb'
    array = ManejoCadena.new.separarCondicion(cadena)
    array.delete("")
    estado = 1
    condicion = AutomataCondicion.new(estado)
    array.each{|simbolo|
      estado = condicion.transacion(simbolo)
      if estado < 0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    return condicion.esFinal(estado)
  end

  def condicion(cadena)
    load 'automata_termino.rb'
    array = ManejoCadena.new.separarCondicion(cadena)
    array.delete("")
    estado = 1
    condicion = AutomataCondicion.new(estado)
    array.each{|simbolo|
      estado = condicion.transacion(simbolo)
      if estado < 0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    if condicion.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end
  end

  def esBloque(cadena)
    estado = 1
    array = ManejoCadena.new.separarBloque(cadena)
    array.delete("")
    bloque = AutomataBloque.new(estado)
    array.each { |simbolo|
      estado = bloque.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    return bloque.esFinal(estado)
  end

  def bloque(cadena)
    estado = 1
    array = ManejoCadena.new.separarBloque(cadena)
    array.delete("")
    bloque = AutomataBloque.new(estado)
    array.each { |simbolo|
      estado = bloque.transicion(simbolo)
      if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    if bloque.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end
  end

  def esInstruccion(cadena)
    estado = 1
    instruccion = AutomataInstruccion.new(estado)
    array = ManejoCadena.new.separarInstruccion(cadena)
    array.delete("")
    array.each{|simbolo|
      estado = instruccion.transicion(simbolo)
      if estado <0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }

    return instruccion.esFinal(estado)
  end

  def instruccion(cadena)
    estado = 1
    instruccion = AutomataInstruccion.new(estado)
    array = ManejoCadena.new.separarInstruccion(cadena)
    array.delete("")
    array.each{|simbolo|
      estado = instruccion.transicion(simbolo)
      if estado < 0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        return "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
      end
    }
    if instruccion.esFinal(estado)
      return ManejoErrores.new.obtenerDescripcion(0)
    elsif estado >0
      return ManejoErrores.new.obtenerDescripcion(-1)
    end
  end

  def queEs(cadena)
    if ManejoAutomata.new.esBloque(cadena)
        return "Bloque"
    elsif ManejoAutomata.new.esInstruccion(cadena)
        return "Instruccion"
    elsif ManejoAutomata.new.esCondicion(cadena)
      return "Condicion"
    elsif ManejoAutomata.new.esIdentificador(cadena)
      return "Identificador"
    elsif ManejoAutomata.new.esNumero(cadena)
      return "Numero"
    elsif ManejoAutomata.new.esFactor(cadena)
      return "Factor"
    elsif ManejoAutomata.new.esTermino(cadena)
      return "Termino"
    elsif ManejoAutomata.new.esExpresion(cadena)
      return "Expresion"
    else
      return "No se sabe"
    end

  end

end