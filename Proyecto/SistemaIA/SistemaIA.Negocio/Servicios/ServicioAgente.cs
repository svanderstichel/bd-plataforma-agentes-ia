using SistemaIA.Datos.Sql;
using SistemaIA.Datos.Sql.Infraestructura;
using SistemaIA.Datos.Sql.Repositorios;
using SistemaIA.Dominio.Entidades;
using SistemaIA.Negocio.DTOs;
using SistemaIA.Negocio.Mappers;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaIA.Negocio.Servicios
{
    public class ServicioAgente
    {
        private readonly RepositorioAgente _repoAgente;
        private readonly RepositorioArchivo _repoArchivo;
        private readonly RepositorioTool _repoTool;
        private readonly RepositorioAgenteArchivo _repoAgenteArchivo;
        private readonly RepositorioAgenteTool _repoAgenteTool;


        public ServicioAgente()
        {
            _repoAgente = new RepositorioAgente();
            _repoArchivo = new RepositorioArchivo();
            _repoTool = new RepositorioTool();
            _repoAgenteArchivo = new RepositorioAgenteArchivo();
            _repoAgenteTool = new RepositorioAgenteTool();
        }

        public List<AgenteDto> ObtenerAgentesDeUsuario(int idUsuario)
        {
            var entidades = _repoAgente.ListarAgentesPorUsuario(idUsuario);

            var listaDto = new List<AgenteDto>();

            foreach (var agente in entidades)
            {
                listaDto.Add(AgenteMapper.Mapear(agente));
            }

            return listaDto;
        }


        public int CrearAgente(AgenteCrearDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Nombre))
                throw new Exception("El nombre del agente es obligatorio.");

            if (dto.Tipo != "S" && dto.Tipo != "A")
                throw new Exception("El tipo de agente es inválido.");

            if (dto.Tipo == "A" && (dto.ArchivosSeleccionados == null || dto.ArchivosSeleccionados.Count == 0))
                throw new Exception("Un agente avanzado debe tener al menos un archivo asociado.");

            using (var conexion = ConexionSQL.ObtenerConexion())
            {
                conexion.Open();
                SqlTransaction transaccion = conexion.BeginTransaction();

                try
                {
                    int idAgente = _repoAgente.CrearAgente(dto.IdUsuario, dto.Nombre, dto.Descripcion, dto.Instruccion, dto.Tipo, conexion, transaccion);

                    if (idAgente <= 0)
                        throw new Exception("No se pudo crear el agente.");

                    if (dto.Tipo == "A")
                    {
                        if (dto.ArchivosSeleccionados.Count > 0)
                        {

                            foreach (int idArchivo in dto.ArchivosSeleccionados)
                            {
                                _repoAgenteArchivo.AsignarArchivo(idAgente, idArchivo, conexion, transaccion);
                            }
                        }
                    }

                    if (dto.ToolsSeleccionadas != null)
                    {
                        if (dto.ToolsSeleccionadas.Count > 0)
                        {

                            foreach (int idTool in dto.ToolsSeleccionadas)
                            {
                                _repoAgenteTool.AsignarTool(idAgente, idTool, conexion, transaccion);
                            }
                        }
                    }

                    transaccion.Commit();

                    return idAgente;
                }
                catch
                {
                    transaccion.Rollback();
                    throw;
                }
                finally
                {
                    conexion?.Close();
                }
            }
        }


        public List<ArchivoDto> ObtenerArchivosUsuario(int idUsuario)
        {
            var entidades = _repoArchivo.ListarPorUsuario(idUsuario);
            var lista = new List<ArchivoDto>();

            foreach (var archivo in entidades)
                lista.Add(ArchivoMapper.Mapear(archivo));

            return lista;
        }

        public List<ToolDto> ObtenerTools()
        {
            var entidades = _repoTool.ListarTools();
            var lista = new List<ToolDto>();

            foreach (var tool in entidades)
                lista.Add(ToolMapper.Mapear(tool));

            return lista;
        }

        public List<int> ObtenerArchivosDeAgente(int idAgente)
        {
            return _repoAgenteArchivo.ObtenerArchivosDeAgente(idAgente);
        }

        public List<int> ObtenerToolsDeAgente(int idAgente)
        {
            return _repoAgenteTool.ObtenerToolsDeAgente(idAgente);
        }


        public AgenteEditarDto ObtenerAgentePorId(int id)
        {
            var entidad = _repoAgente.ObtenerPorId(id);

            if (entidad == null)
                return null;

            return AgenteMapper.MapearADto(entidad);
        }



        public void EditarAgente(AgenteEditarDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Nombre))
                throw new Exception("El nombre es obligatorio.");

            using (var conexion = ConexionSQL.ObtenerConexion())
            {
                conexion.Open();
                var trans = conexion.BeginTransaction();

                try
                {
                    var entidad = AgenteMapper.MapearEditar(dto);

                    _repoAgente.ActualizarAgente(entidad, conexion, trans);

                    _repoAgenteArchivo.EliminarArchivos(entidad.IdAgente, conexion, trans);
                    _repoAgenteTool.EliminarTools(entidad.IdAgente, conexion, trans);

                    if (dto.Tipo == "A" && dto.ArchivosSeleccionados != null)
                    {
                        foreach (var idArchivo in dto.ArchivosSeleccionados)
                            _repoAgenteArchivo.AsignarArchivo(entidad.IdAgente, idArchivo, conexion, trans);
                    }

                    if (dto.ToolsSeleccionadas != null)
                    {
                        foreach (var idTool in dto.ToolsSeleccionadas)
                            _repoAgenteTool.AsignarTool(entidad.IdAgente, idTool, conexion, trans);
                    }

                    trans.Commit();
                }
                catch (SqlException)
                {
                    trans.Rollback();
                    throw;
                }
                finally
                {
                    conexion?.Close();
                }
            }
        }




    }
}
