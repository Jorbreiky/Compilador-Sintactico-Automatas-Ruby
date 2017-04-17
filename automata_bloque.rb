require_relative 'automata.rb'
require_relative 'manejo_cadena.rb'
require_relative 'manejo_automata.rb'
class AutomataBloque<Automata
  def initialize(estado)
    super(estado)
    @estadosFinales = [8]
  end

  def transicion(cadena)
    mCadena = ManejoCadena.new
    mAutomata = ManejoAutomata.new

    case @estado
      when 1
        if mCadena.esConst(cadena)
          @estado = 2
        elsif mCadena.esVar(cadena)
          @estado = 3
        elsif mCadena.esProcedure(cadena)
          @estado = 4
        else
          @estado = -22
        end

      when 2
        if mAutomata.esIdentificador(cadena)
          @estado = 5
        else
          @estado = -23
        end

      when 3
        if mAutomata.esIdentificador(cadena)
          @estado = 9
        else
          @estado= -24
        end

      when 4
        if mAutomata.esIdentificador(cadena)
          @estado = 10
        else
          @estado= -25
        end

      when 5
        if mCadena.esIgual(cadena)
          @estado = 6
        else
          @estado= -26
        end
      when 6
        if mAutomata.esIdentificador(cadena)
          @estado = 7
        else
          @estado= -27
        end

      when 7
        if mCadena.esComa(cadena)
          @estado = 2
        elsif mCadena.esPuntoYComa(cadena)
          @estado = 8
        else
          @estado= -28
        end
      when 9
        if mCadena.esPuntoYComa(cadena)
          @estado = 8
        elsif mCadena.esComa(cadena)
          @estado = 3
        else
          @estado = -28
        end

      when 10
        if mCadena.esPuntoYComa(cadena)
          @estado = 8
        else
          @estado = -29
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