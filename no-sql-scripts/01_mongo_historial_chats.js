use SistemaIA_Mongo

db.chats.drop()
db.createCollection("chats")

db.chats.insertMany([
  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f00"),
    idChatSQL: 1,
    idAgente: 1,
    idUsuario: 1,
    nombreChat: "Comparación de ventas trimestrales",
    fechaCreacion: ISODate("2025-10-25T10:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un asistente contable especializado en análisis financiero.", timestamp: ISODate("2025-10-25T10:00:00Z") },
      { role: "user", content: "Hola, necesito comparar los resultados de ventas del trimestre 3 con el trimestre anterior para mi presentación.", timestamp: ISODate("2025-10-25T10:00:10Z") },
      { role: "assistant", content: "Perfecto. Revisaré los archivos 'Ventas_Q3_2025.csv' y 'Ventas_Q2_2025.csv'.", timestamp: ISODate("2025-10-25T10:00:20Z") },
      { role: "tool", content: "Procesando comparación de ventas Q2 vs Q3.", metadata: { tool: "Python", type: "table", input: ["Ventas_Q2_2025.csv", "Ventas_Q3_2025.csv"], output: [ { Categoria: "Software", Q2: 450000, Q3: 510000 }, { Categoria: "Servicios", Q2: 500000, Q3: 540000 }, { Categoria: "Hardware", Q2: 545000, Q3: 530000 } ], resumen: { Total_Q2: 1495000, Total_Q3: 1580000, Variación: "+5.7%" }, status: "ok" }, timestamp: ISODate("2025-10-25T10:00:30Z") },
      { role: "assistant", content: "El trimestre 3 superó al anterior en un 5.7%, con mejoras notables en software y servicios.", timestamp: ISODate("2025-10-25T10:00:40Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f01"),
    idChatSQL: 2,
    idAgente: 1,
    idUsuario: 1,
    nombreChat: "Clientes principales del año",
    fechaCreacion: ISODate("2025-10-26T11:00:00Z"),
    mensajes: [
      { role: "user", content: "Necesito un resumen con los cinco clientes que más aportaron a las ventas de este año.", timestamp: ISODate("2025-10-26T11:00:05Z") },
      { role: "assistant", content: "Analizando registros anuales y cruzando datos de facturación.", timestamp: ISODate("2025-10-26T11:00:15Z") },
      { role: "tool", content: "Extracción de clientes más relevantes.", metadata: { tool: "Python", type: "table", output: [ { Cliente: "Distribuidora Andina", Participación: "21.4%" }, { Cliente: "Textiles Norte", Participación: "18.7%" }, { Cliente: "Logisur SRL", Participación: "13.2%" }, { Cliente: "TechPartners", Participación: "11.5%" }, { Cliente: "Ferrosur", Participación: "9.8%" } ], totalClientes: 5, status: "ok" }, timestamp: ISODate("2025-10-26T11:00:30Z") },
      { role: "assistant", content: "Aquí tienes el ranking. Logisur SRL tuvo un incremento de 30% en pedidos este año.", timestamp: ISODate("2025-10-26T11:00:45Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f02"),
    idChatSQL: 3,
    idAgente: 2,
    idUsuario: 1,
    nombreChat: "Reporte de campañas y clientes nuevos",
    fechaCreacion: ISODate("2025-10-27T09:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un bot de marketing que gestiona información sobre campañas y clientes.", timestamp: ISODate("2025-10-27T09:00:00Z") },
      { role: "user", content: "Cuántos clientes nuevos tuvimos en octubre y qué campañas siguen activas?", timestamp: ISODate("2025-10-27T09:00:10Z") },
      { role: "tool", content: "Consultando datos del CRM.", metadata: { tool: "Web Scraper", type: "table", output: [ { Campaña: "Primavera Digital", Estado: "Activa", Conversiones: 124 }, { Campaña: "Black Week", Estado: "Activa", Conversiones: 80 }, { Campaña: "CRM Update 2.0", Estado: "Activa", Conversiones: 52 } ], clientesNuevos: 48, status: "ok" }, timestamp: ISODate("2025-10-27T09:00:25Z") },
      { role: "assistant", content: "Se sumaron 48 nuevos clientes y hay tres campañas activas con 256 conversiones en total.", timestamp: ISODate("2025-10-27T09:00:35Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f03"),
    idChatSQL: 4,
    idAgente: 3,
    idUsuario: 1,
    nombreChat: "Contrato proveedor TechPartners",
    fechaCreacion: ISODate("2025-10-28T15:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un generador de contratos legales con plantillas configurables.", timestamp: ISODate("2025-10-28T15:00:00Z") },
      { role: "user", content: "Generá un contrato base con cláusula de confidencialidad y rescisión a 30 días.", timestamp: ISODate("2025-10-28T15:00:10Z") },
      { role: "assistant", content: "Creando contrato con las condiciones solicitadas...", timestamp: ISODate("2025-10-28T15:00:20Z") },
      { role: "tool", content: "Generación de contrato legal.", metadata: { tool: "Python", type: "table", output: [ { Cláusula: "Confidencialidad", Estado: "Incluida" }, { Cláusula: "Rescisión anticipada", Aviso: "30 días" } ], status: "ok" }, timestamp: ISODate("2025-10-28T15:00:30Z") },
      { role: "assistant", content: "Contrato generado correctamente y guardado en la carpeta de documentos legales.", timestamp: ISODate("2025-10-28T15:00:45Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f04"),
    idChatSQL: 5,
    idAgente: 3,
    idUsuario: 1,
    nombreChat: "Revisión de renovación contractual",
    fechaCreacion: ISODate("2025-10-29T16:30:00Z"),
    mensajes: [
      { role: "user", content: "Podés revisar si la cláusula de renovación está bien redactada en el contrato?", timestamp: ISODate("2025-10-29T16:30:10Z") },
      { role: "assistant", content: "Analizando el texto... detecté que no se especifica límite de renovaciones.", timestamp: ISODate("2025-10-29T16:30:20Z") },
      { role: "user", content: "Agregá que la renovación automática sea solo una vez.", timestamp: ISODate("2025-10-29T16:30:30Z") },
      { role: "assistant", content: "Listo, ya actualicé la redacción y guardé el nuevo contrato en la base de datos.", timestamp: ISODate("2025-10-29T16:30:40Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f05"),
    idChatSQL: 6,
    idAgente: 4,
    idUsuario: 2,
    nombreChat: "Problema de acceso a cuenta",
    fechaCreacion: ISODate("2025-10-25T09:30:00Z"),
    mensajes: [
      { role: "system", content: "Eres un bot de soporte de nivel 1 que brinda ayuda sobre cuentas y contraseñas.", timestamp: ISODate("2025-10-25T09:30:00Z") },
      { role: "user", content: "No puedo acceder a mi cuenta, dice que mi contraseña es incorrecta aunque la cambié ayer.", timestamp: ISODate("2025-10-25T09:30:05Z") },
      { role: "assistant", content: "Verificá que el bloqueo de mayúsculas esté desactivado. Si persiste, podés usar el enlace '¿Olvidaste tu contraseña?'.", timestamp: ISODate("2025-10-25T09:30:10Z") },
      { role: "user", content: "Lo intenté, pero no me llega el correo de recuperación.", timestamp: ISODate("2025-10-25T09:30:15Z") },
      { role: "assistant", content: "Revisá la carpeta de spam. Si no está, informame y lo escalo al área técnica.", timestamp: ISODate("2025-10-25T09:30:25Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f06"),
    idChatSQL: 7,
    idAgente: 5,
    idUsuario: 2,
    nombreChat: "Resumen de manual técnico",
    fechaCreacion: ISODate("2025-10-26T14:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un analista de documentos que resume textos largos.", timestamp: ISODate("2025-10-26T14:00:00Z") },
      { role: "user", content: "Subí un PDF con 40 páginas, necesito un resumen con los puntos clave.", timestamp: ISODate("2025-10-26T14:00:05Z") },
      { role: "tool", content: "Análisis de texto PDF.", metadata: { tool: "Python", type: "text", output: "El documento trata sobre la actualización de un sistema ERP, enfatiza la seguridad y la integración modular." }, timestamp: ISODate("2025-10-26T14:00:15Z") },
      { role: "assistant", content: "El texto es técnico y detalla mejoras en seguridad y escalabilidad del sistema.", timestamp: ISODate("2025-10-26T14:00:25Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f07"),
    idChatSQL: 8,
    idAgente: 5,
    idUsuario: 2,
    nombreChat: "Conversión PDF a texto",
    fechaCreacion: ISODate("2025-10-27T14:30:00Z"),
    mensajes: [
      { role: "user", content: "Convertí el PDF a texto para poder editarlo.", timestamp: ISODate("2025-10-27T14:30:05Z") },
      { role: "tool", content: "Conversión PDF → TXT.", metadata: { tool: "Python", type: "text", output: "Texto exportado correctamente al archivo 'Manual_Tecnico.txt'.", status: "ok" }, timestamp: ISODate("2025-10-27T14:30:15Z") },
      { role: "assistant", content: "La conversión se realizó con éxito. El archivo 'Manual_Tecnico.txt' está disponible en la carpeta compartida.", timestamp: ISODate("2025-10-27T14:30:25Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f08"),
    idChatSQL: 9,
    idAgente: 6,
    idUsuario: 2,
    nombreChat: "Entrenamiento atención al cliente",
    fechaCreacion: ISODate("2025-10-28T10:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un bot de entrenamiento que enseña técnicas de atención al cliente.", timestamp: ISODate("2025-10-28T10:00:00Z") },
      { role: "user", content: "Podés darme un conjunto de ejercicios para practicar respuestas ante reclamos?", timestamp: ISODate("2025-10-28T10:00:05Z") },
      { role: "assistant", content: "Por supuesto. Incluyo ejemplos de casos con clientes frustrados, errores de facturación y consultas injustificadas.", timestamp: ISODate("2025-10-28T10:00:10Z") },
      { role: "tool", content: "Generación de ejercicios de atención al cliente.", metadata: { tool: "Python", type: "table", output: [ { Escenario: "Demora en envío", Recomendado: "Ofrecer disculpas, verificar pedido y ofrecer seguimiento" }, { Escenario: "Reclamo injustificado", Recomendado: "Responder con empatía y explicar procedimiento" } ] }, timestamp: ISODate("2025-10-28T10:00:25Z") },
      { role: "assistant", content: "Listo. Tenés dos ejercicios cargados para hoy.", timestamp: ISODate("2025-10-28T10:00:35Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f09"),
    idChatSQL: 10,
    idAgente: 7,
    idUsuario: 3,
    nombreChat: "Análisis de contrato legal",
    fechaCreacion: ISODate("2025-10-25T13:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un agente legal que revisa cláusulas contractuales.", timestamp: ISODate("2025-10-25T13:00:00Z") },
      { role: "user", content: "Revisá el contrato con TechPartners y marcá cláusulas con riesgo alto.", timestamp: ISODate("2025-10-25T13:00:05Z") },
      { role: "tool", content: "Análisis de texto legal.", metadata: { tool: "Python", type: "table", output: [ { Clausula: "5.3", Riesgo: "Alto" }, { Clausula: "7.1", Riesgo: "Moderado" } ], status: "ok" }, timestamp: ISODate("2025-10-25T13:00:15Z") },
      { role: "assistant", content: "Identifiqué dos cláusulas con riesgo: 5.3 y 7.1. Recomiendo revisarlas con el equipo jurídico.", timestamp: ISODate("2025-10-25T13:00:25Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f10"),
    idChatSQL: 11,
    idAgente: 8,
    idUsuario: 3,
    nombreChat: "Clasificación de imágenes del proyecto",
    fechaCreacion: ISODate("2025-10-26T09:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un asistente que clasifica imágenes y documentos escaneados.", timestamp: ISODate("2025-10-26T09:00:00Z") },
      { role: "user", content: "Agrupá las imágenes por tipo de documento.", timestamp: ISODate("2025-10-26T09:00:05Z") },
      { role: "tool", content: "Clasificación de imágenes.", metadata: { tool: "Image Vision", type: "table", output: [ { Tipo: "Planos", Cantidad: 4 }, { Tipo: "Contratos", Cantidad: 5 }, { Tipo: "Otros", Cantidad: 3 } ] }, timestamp: ISODate("2025-10-26T09:00:15Z") },
      { role: "assistant", content: "Clasificación completada. Guardé los resultados en 'Clasificacion_Imagenes.xlsx'.", timestamp: ISODate("2025-10-26T09:00:25Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f11"),
    idChatSQL: 12,
    idAgente: 9,
    idUsuario: 3,
    nombreChat: "Análisis de tono de correo",
    fechaCreacion: ISODate("2025-10-27T11:00:00Z"),
    mensajes: [
      { role: "system", content: "Eres un gestor de comunicaciones que evalúa el tono de correos electrónicos.", timestamp: ISODate("2025-10-27T11:00:00Z") },
      { role: "user", content: "Analizá el tono del correo que envié a Recursos Humanos.", timestamp: ISODate("2025-10-27T11:00:05Z") },
      { role: "tool", content: "Análisis de tono.", metadata: { tool: "Sentiment Classifier", type: "text", output: "El correo tiene un tono formal y empático." }, timestamp: ISODate("2025-10-27T11:00:10Z") },
      { role: "assistant", content: "El mensaje transmite cortesía y profesionalismo. No presenta carga emocional negativa.", timestamp: ISODate("2025-10-27T11:00:20Z") }
    ]
  },

  {
    _id: ObjectId("654a12f8b32c7f9d2a4b9f12"),
    idChatSQL: 13,
    idAgente: 9,
    idUsuario: 3,
    nombreChat: "Detección de correos negativos",
    fechaCreacion: ISODate("2025-10-28T12:15:00Z"),
    mensajes: [
      { role: "user", content: "Mostrame los correos con tono negativo en la carpeta de soporte.", timestamp: ISODate("2025-10-28T12:15:05Z") },
      { role: "tool", content: "Escaneo de mensajes entrantes.", metadata: { tool: "Sentiment Classifier", type: "table", output: [ { Remitente: "cliente1@empresa.com", Tono: "Negativo" }, { Remitente: "cliente2@empresa.com", Tono: "Negativo" }, { Remitente: "cliente3@empresa.com", Tono: "Negativo" } ] }, timestamp: ISODate("2025-10-28T12:15:10Z") },
      { role: "assistant", content: "Se detectaron 3 mensajes con tono negativo. Recomiendo responderlos con tono conciliador y ofrecer asistencia directa.", timestamp: ISODate("2025-10-28T12:15:20Z") }
    ]
  }

])
