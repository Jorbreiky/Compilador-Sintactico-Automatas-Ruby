require_relative 'manejo_cadena.rb'
require_relative 'automata_numero.rb'
require_relative 'manejo_errores.rb'
require_relative 'manejo_automata.rb'
require_relative 'automata_expresion.rb'
require 'fox16'
include Fox
class VentanaCompilador<FXMainWindow

  def initialize(app)
    super(app,"Ventana",:width=>650,:height=>500)
    fuente = FXFont.new(app,"Modern,120,BOLD,0")

    lblSintaxis = FXLabel.new(self,"SINTAXIS",:opts=>LAYOUT_EXPLICIT,:x=>20,:y=>40,:width=>600,:height=>30)

    @txtSintaxis = FXText.new(self,:opts=>LAYOUT_EXPLICIT,:x=>20,:y=>80,:width=>600,:height=>200)
    @txtSintaxis.font= FXFont.new(app,"Aparajita,120,BOLD,0")
    @txtSintaxis.setText("")

    @txtConsola = FXText.new(self,:opts=>LAYOUT_EXPLICIT,:x=>20,:y=>285,:width=>600,:height=>170)
    @txtConsola.font= FXFont.new(app,"Aparajita,80,BOLD,0")
    @txtConsola.setText("Consola: \n")


    menubar = FXMenuBar.new(self,LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    filemenu = FXMenuPane.new(self)
    FXMenuCommand.new(filemenu, "&Abrir\tCtl-O").connect(SEL_COMMAND) do
      openDialog = FXFileDialog.new(app, "Buscar Archivo")
      openDialog.setDirectory("C:/Users/Jorge/Desktop")
      if openDialog.execute != 0
          i = 1
          @txtSintaxis.setText("")
          @txtConsola.setText("Consola:\n")

          sintaxis=File.open( openDialog.filename, "r" ).read
          array = ManejoCadena.new.separarCadena(sintaxis)

            sintaxis.each_char{|letra|
              @txtSintaxis.appendText(letra)
            }

          bandera = false
            array.each do |linea|
              if linea.match(/^const.*|^var.*|^procedure.*/)
                  cadena = "Linea #{i}: #{ManejoAutomata.new.bloque(linea)}\n"
              elsif linea.match(/^call.*|^begin.*|^if.*|^while.*|.*:=.*/)
                  cadena = "Linea #{i}: #{ManejoAutomata.new.instruccion(linea)}\n"
              elsif linea.match(/[.]/)
                cadena = "Fin del programa\n"
                if array.length == i
                  bandera = true
                else
                  break
                end
              else
                if linea.length == 0
                  cadena = ""
                else
                  cadena = "no se econtro palabra recervada #{linea.to_s}\n"
                end
              end

              cadena.each_char{|letra|
                @txtConsola.appendText(letra)
              }
              i+=1
            end
        if bandera
          @txtConsola.appendText("PROCESS SUCCESSFUL")
        else
          @txtConsola.appendText("PROCESS FAIL")
        end

      end

    end
    FXMenuCommand.new(filemenu, "&Salir\tCtl-Q", nil, getApp(), FXApp::ID_QUIT)
    FXMenuTitle.new(menubar, "&Archivo", nil, filemenu)

    lblFondo = FXLabel.new(self,"",:opts=>LAYOUT_EXPLICIT,:x=>0,:y=>0,:width=>700,:height=>700)
    lblFondo.icon=FXPNGIcon.new(app,File.open("IMG/fondo.png","rb").read)
    lblFondo.iconPosition=ICON_BEFORE_TEXT
    lblFondo.layoutHints = LAYOUT_CENTER_X|LAYOUT_CENTER_Y
  end

  def create
    super
  end

  def show
    super(PLACEMENT_SCREEN)
  end
end

=begin
=end
app = FXApp.new
main = VentanaCompilador.new(app)
main.show
app.create()
app.run()