require_relative 'manejo_cadena.rb'
require_relative 'automata_numero.rb'
require_relative 'manejo_errores.rb'
require_relative 'manejo_automata.rb'
require_relative 'automata_expresion.rb'
require 'fox16'
include Fox
class Main<FXMainWindow

  def initialize(app)
    super(app,"Ventana",:width=>500,:height=>200)
    fuente = FXFont.new(app,"Modern,120,normal,0")

    @lblCadena = FXLabel.new(self,"Cadena: ",:opts=>LAYOUT_EXPLICIT,:x=>10,:y=>10,:width=>50,:height=>30)
    @lblCadena.justify=JUSTIFY_LEFT
    @lblCadena.font=fuente

    @txtCadena = FXText.new(self,:opts=>LAYOUT_EXPLICIT,:x=>65,:y=>10,:width=>230,:height=>30)
    @txtCadena.font=fuente

    @button = FXButton.new(self,"Aceptar",:opts=>LAYOUT_EXPLICIT,:x=>300,:y=>10,:width=>120,:height=>30)
    @button.font=fuente

    @lblResultado = FXLabel.new(self,"Resultado: ",:opts=>LAYOUT_EXPLICIT,:x=>10,:y=>160,:width=>400,:height=>30)
    @lblResultado.justify=JUSTIFY_LEFT
    @lblResultado.font=fuente

    lblFondo = FXLabel.new(self,"",:opts=>LAYOUT_EXPLICIT,:x=>0,:y=>0,:width=>700,:height=>700)
    lblFondo.icon=FXPNGIcon.new(app,File.open("IMG/fondo.png","rb").read)
    lblFondo.iconPosition=ICON_BEFORE_TEXT
    lblFondo.layoutHints = LAYOUT_CENTER_X|LAYOUT_CENTER_Y

    @button.connect(SEL_COMMAND)do
      cadena = @txtCadena.getText.to_s
      estado = 1

      automataExpresion = AutomataExpresion.new(estado)
      @lblResultado.setText("Resultado: ")
      tokens = ManejoCadena.new.separarExpresion(cadena)

      tokens.each{|simbolo|
        estado = automataExpresion.transicion(simbolo)
        if(estado < 0)
          @lblResultado.setText("RESULTADO: "+ManejoErrores.new().obtenerDescripcion(estado))
          break
        end
      }
      if automataExpresion.esFinal(estado)
          @lblResultado.setText("RESULTADO: "+ManejoErrores.new().obtenerDescripcion(0))
      elsif(estado>=0)
          @lblResultado.setText("RESULTADO: "+ManejoErrores.new.obtenerDescripcion(-1))
      end
    end
  end

  def create
    super
  end

  def show
    super(PLACEMENT_SCREEN)
  end

end

cadena = "begin a:=x;b:=y;z:=o; while b>0 do begin if odd b then z:=z+a a:=z*a;b:=b/2; end end"

array = cadena.split(" ")
puts "".center(80,"*")
array.each{|simbolo|
  puts simbolo
}
puts "".center(80,"*")
