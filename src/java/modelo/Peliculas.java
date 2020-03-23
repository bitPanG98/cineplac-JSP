/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author Poolvazo
 */
public class Peliculas {
    
    public Peliculas(){
    }
    
    private String codigo;
    private String nombre;
    private String duracion;
    private String descripcion;
    private String stock;
    private String genero;
    private String precio;
    private String estado;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public  String getDuracion(){
        return duracion;
    }
    
    public  void setDuracion(String duracion){
        this.duracion = duracion;
    }
    
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public  String getStock(){
        return stock;
    }
    
    public  void setStock(String stock){
        this.stock = stock;
    }
    
    public String getGenero(){
        return genero;
    }
    
    public void setGenero(String genero){
        this.genero = genero;
    }
    
    public String getPrecio(){
        return precio;
    }
    
    public void setPrecio(String precio){
        this.precio = precio;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        String estadogenero="";
       
        if (estado.equals("1")) {
            estadogenero = "Activo";
        }else{
            estadogenero = "Inactivo";
        }
        this.estado = estadogenero;
    }
    
}
