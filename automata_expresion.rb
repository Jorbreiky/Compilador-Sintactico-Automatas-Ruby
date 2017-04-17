require_relative 'automata.rb'
require_relative 'automata_termino.rb'
require_relative 'manejo_automata.rb'
require_relative 'manejo_cadena.rb'
class AutomataExpresion < Automata
  def initialize(estado)
    super(estado)
    @estadosFinales = [3]
  end

  def transicion(cadena)
    case @estado
      when 1
        if ManejoCadena.new.esSignoMasMenos(cadena)
          @estado=2
        elsif ManejoAutomata.new.esTermino(cadena)
          @estado=3
        else
          @estado=-16
        end
      when 2
        if ManejoAutomata.new.esTermino(cadena)
          @estado=3
        else
          @estado=-17
        end
      when 3
        if ManejoCadena.new.esSignoMasMenos(cadena)
          @estado=2
        else
          @estado=-18
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