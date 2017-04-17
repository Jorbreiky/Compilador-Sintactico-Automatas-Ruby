require_relative 'automata.rb'
require_relative 'manejo_automata.rb'
require_relative 'manejo_cadena.rb'
class AutomataTermino<Automata

  def initialize(estado)
    super(estado)
    @estadosFinales =[2]
  end

  def transicion(cadena)
    case @estado
      when 1
        if ManejoAutomata.new.esFactor(cadena)
          @estado=2
        else
          @estado = -13
        end
      when 2
        if(ManejoCadena.new.esSignoPorEntre(cadena))
          @estado=3
        else
          @estado=-14
        end
      when 3
        if ManejoAutomata.new.esFactor(cadena)
          @estado=2
        else
          @estado=-15
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


