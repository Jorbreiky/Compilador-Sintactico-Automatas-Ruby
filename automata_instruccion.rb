require_relative 'automata.rb'
require_relative 'manejo_automata.rb'
require_relative 'manejo_cadena.rb'

class AutomataInstruccion<Automata
  def initialize(estado)
    super(estado)
    @estadosFinales = [4]
  end

  def transicion(cadena)
    case @estado
      when 1
        if ManejoCadena.new.esCall(cadena)
          @estado = 5
        elsif ManejoCadena.new.esBegin(cadena)
          @estado =6
        elsif ManejoCadena.new.esIf(cadena)
          @estado = 8
        elsif ManejoCadena.new.esWhile(cadena)
          @estado = 11
        elsif ManejoAutomata.new.esIdentificador(cadena)
            @estado = 2
        elsif cadena.length==0
          @estado = 4
        else
          @estado = -30
        end

      when 2
        if ManejoCadena.new.esDosPuntosIgual(cadena)
          @estado = 3
        else
          @estado = -31
        end

      when 3
        if ManejoAutomata.new.esExpresion(cadena)
          @estado = 4
        else
          @estado = -32
        end
      when 4
        if ManejoCadena.new.esPunto(cadena)
          @estado = 4
        elsif ManejoCadena.new.esPuntoYComa(cadena)
          @estado = 4
        else
          @estado=-2
        end

      when 5
        if ManejoAutomata.new.esIdentificador(cadena)
          @estado = 4
        else
          @estado = -33
        end

      when 6
        if ManejoAutomata.new.esInstruccion(cadena)
          @estado = 7
        else
          @estado = -34
        end

      when 7
        if ManejoCadena.new.esEnd(cadena)
          @estado = 4
        elsif ManejoCadena.new.esPuntoYComa(cadena)
          @estado = 6
        else
          @estado = -35
        end

      when 8
        if ManejoAutomata.new.esCondicion(cadena)
          @estado = 9
        else
          @estado = -36
        end

      when 9
        if ManejoCadena.new.esThen(cadena)
          @estado = 10
        else
          @estado = -37
        end

      when 10
        if ManejoAutomata.new.esInstruccion(cadena)
          @estado = 4
        else
          @estado = -38
        end

      when 11
        if ManejoAutomata.new.esCondicion(cadena)
          @estado = 12
        else
          @estado = -36
        end

      when 12
        if ManejoCadena.new.esDo(cadena)
          @estado = 10
        else
          @estado = -39
        end
    end
  end

  def esFinal(estado)
    @estadosFinales.each{|estadoFinal|
      if(estado==estadoFinal)
        return true
      end
    }
    return false
  end
end