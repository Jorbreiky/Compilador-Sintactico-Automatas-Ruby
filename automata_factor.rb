require_relative 'automata.rb'
require_relative 'manejo_cadena.rb'
require_relative 'manejo_automata.rb'
require_relative 'automata_numero.rb'

class AutomataFactor<Automata
  def initialize(estado)
    super(estado)
    @estadosFinales = [4]
  end

  def transicion(cadena)
    case @estado
      when 1
        if ManejoAutomata.new.esIdentificador(cadena)
          @estado = 4
        elsif ManejoAutomata.new.esNumero(cadena)
          @estado = 4
        elsif ManejoCadena.new.esParentesis1(cadena)
          @estado = 2
        else
          @estado=-2
        end
      when 2
        if ManejoAutomata.new.esExpresion(cadena)
          @estado=3
        else
          @estado = -11
        end
      when 3
        if ManejoCadena.new.esParentesis2(cadena)
          @estado=4
        else
          @estado=-12
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