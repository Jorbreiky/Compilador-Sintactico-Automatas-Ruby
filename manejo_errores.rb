require_relative 'manejo_archivos'
class ManejoErrores
  def obtenerDescripcion(estado)
    return ManejoArchivos.new.obtenerDescripcionExcel("Errores.xls",estado)
  end
end