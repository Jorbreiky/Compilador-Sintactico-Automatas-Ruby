require_relative 'automata.rb'
require_relative 'manejo_automata.rb'
class AutomataCondicion < Automata
  def initialize(estado)
    super(estado)
    @estadosFinales = [3]
  end

  def transacion(cadena)
    case @estado
      when 1
        if ManejoCadena.new.esODD(cadena)
          @estado = 2
        elsif ManejoAutomata.new.esExpresion(cadena)
          @estado = 4
        else
          @estado = -19
        end
      when 2
        if ManejoAutomata.new.esExpresion(cadena)
          @estado = 3
        else
          @estado = -20
        end
      when 4
        if ManejoCadena.new.esOperadorLogico(cadena)
          @estado = 2
        else
          @estado = -21
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