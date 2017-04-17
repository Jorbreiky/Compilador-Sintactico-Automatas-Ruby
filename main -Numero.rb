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

    @lblEstadoAnterior = FXLabel.new(self,"Estado Anterior: ",:opts=>LAYOUT_EXPLICIT,:x=>10,:y=>55,:width=>400,:height=>30)
    @lblEstadoAnterior.justify=JUSTIFY_LEFT
    @lblEstadoAnterior.font=fuente
    @lblEstadoAnterior

    @lblSimbolo = FXLabel.new(self,"Simbolo: ",:opts=>LAYOUT_EXPLICIT,:x=>10,:y=>90,:width=>400,:height=>30)
    @lblSimbolo.justify=JUSTIFY_LEFT
    @lblSimbolo.font=fuente


    @lblEstadoActual = FXLabel.new(self,"Estado Actual: ",:opts=>LAYOUT_EXPLICIT,:x=>10,:y=>125,:width=>400,:height=>30)
    @lblEstadoActual.justify=JUSTIFY_LEFT
    @lblEstadoActual.font=fuente


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
      automataNumero = AutomataNumero.new(estado)
      @lblEstadoActual.setText("")
      @lblResultado.setText("Resultado: ")
      @lblSimbolo.setText("")
      @lblEstadoAnterior.setText("")

      Thread.new do
        cadena.each_char{|simbolo|
          @lblEstadoAnterior.setText("Estado Anterior: "+estado.to_s)
          @lblSimbolo.setText("Simbolo: "+simbolo.to_s)
          estado = automataNumero.transicion(simbolo)
          @lblEstadoActual.setText("Estado Actual: "+estado.to_s)

          if(estado < 0)
            @lblResultado.setText("RESULTADO: "+ManejoErrores.new().obtenerDescripcion(estado))
            break
          end
          sleep 0.7
        }
        if automataNumero.esFinal(estado)
          @lblResultado.setText("RESULTADO: "+ManejoErrores.new().obtenerDescripcion(0))
        elsif(estado>=0)
          @lblResultado.setText("RESULTADO: "+ManejoErrores.new.obtenerDescripcion(-1))
        end
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

