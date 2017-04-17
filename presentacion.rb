require_relative 'ventana_compilador'
require 'fox16'
include Fox
class Presentacion < FXMainWindow

  def initialize(app)
    super(app,"Presentacion",:width=>800,:height=>500)
    @app =app
    fuente = FXFont.new(app,"Modern,180,Oblique,ExtraBold,0")

    @progressTarget = FXDataTarget.new(0)

    encabezado = "Instituto Tecnologico de Chilpancingo"
    materia = "Materia : Lenguajes y Automatas II"
    nombres = "Alumnos: \n->Lucia Mota Castrejon \n->Jorge Mañon Arroyo\nSemestre: 7"
    descripcion = "Descripción: Programa que analiza un archivo de texto\n y verifica que este bien escrita la sintaxis"

    lblEncabezado = FXLabel.new(self,encabezado,:opts=>LAYOUT_EXPLICIT,:width=>700,:height=>30,:x=>10,:y=>10)
    lblEncabezado.justify=JUSTIFY_CENTER_X
    lblEncabezado.textColor="blue"
    lblEncabezado.font = fuente

    lblMateria = FXLabel.new(self,materia,:opts=>LAYOUT_EXPLICIT,:width=>700,:height=>30,:x=>10,:y=>45)
    lblMateria.justify=JUSTIFY_LEFT
    lblMateria.textColor="blue"
    lblMateria.font = fuente

    lblNombres = FXLabel.new(self,nombres,:opts=>LAYOUT_EXPLICIT,:width=>700,:height=>120,:x=>10,:y=>80)
    lblNombres.justify=JUSTIFY_LEFT
    lblNombres.textColor="blue"
    lblNombres.font = fuente

    lblDescripcion = FXLabel.new(self,descripcion,:opts=>LAYOUT_EXPLICIT,:width=>700,:height=>60,:x=>10,:y=>205)
    lblDescripcion.justify=JUSTIFY_LEFT
    lblDescripcion.textColor="blue"
    lblDescripcion.font = fuente


    @barra = FXProgressBar.new(self, @progressTarget, FXDataTarget::ID_VALUE,LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X|FRAME_SUNKEN|FRAME_THICK)
    @barra.barBGColor="green"
    @barra.barColor="black"
    lblFondo = FXLabel.new(self,"",:opts=>LAYOUT_EXPLICIT,:width=>700,:height=>500,:x=>0,:y=>0)
    lblFondo.icon=FXJPGIcon.new(app,File.open("IMG/fondo.jpg","rb").read)
    lblFondo.iconPosition=ICON_BEFORE_TEXT
    lblFondo.layoutHints=LAYOUT_CENTER_X|LAYOUT_CENTER_Y

  end

  def create
    super
    getApp().addTimeout(50, method(:onTimeout))
    show(PLACEMENT_SCREEN)
  end

  def onTimeout(sender, sel, ptr)
      @progressTarget.value = (@progressTarget.value + 1) % 100
      if @progressTarget.value==99
          mainWindow2 = VentanaCompilador.new(@app)#,"Ventana 2",icon=nil,miniIcon=nil,opts=DECOR_ALL,x=0,y=0,width=500,height=500,padLeft=0,padRight=0,padTop=0,padBottom=0,hSpacing=4,vSpacing=4)
          mainWindow2.create
          mainWindow2.show
          self.close
      else
        getApp().addTimeout(50, method(:onTimeout))
      end
  end
end

app = FXApp.new
Presentacion.new(app)
app.create
app.run