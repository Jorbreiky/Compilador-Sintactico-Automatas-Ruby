require 'spreadsheet'
class ManejoArchivos
  def leerArchivoTXT(nombreArchivo)
    nombreArchivo<<".txt"
    errores = Hash.new
    numeros = /[+-]?\d/
    descripcion = /[+-]?\d\"([a-zA-Z]+\s+)+\"/
    file = File.new(nombreArchivo,"r")
    file.each{|linea|
      errores[linea.scan(numeros)[0]] = linea.split(",")[1]
    }
    return errores
  end

  def obtenerDescripcionTXT(estado)
    errores = leerArchivo("errores")
    #errores.each{|key,error| print "#{key}:#{error}\n"}
     return errores[estado.to_s]
  end

  def obtenerDescripcionExcel(archivo,error)
    @book = Spreadsheet.open(archivo)
    @sheet1 = @book.worksheet 0
    0.upto(@sheet1.last_row_index) do|i|
      if @sheet1.cell(i,0) == error
        return @sheet1.cell(i,1)
      end
    end
  end

end