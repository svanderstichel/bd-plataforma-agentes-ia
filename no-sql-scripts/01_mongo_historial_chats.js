use SistemaIA;

//  creación de la colección de chats
db.createCollection("chats");

// datos de test tomando los datos que tenemos en el script Datos.sql
db.chats.insertMany([
  {
    idChatSQL: 1,  // chat de Julián Mondillo con su agente "Asistente Contable"
    idUsuario: 1,
    idAgente: 1,
    fechaCreacion: ISODate("2025-10-20T14:40:00Z"),
    mensajes: [
      {
        role: "system",
        content: "Eres un asistente contable que prepara balances e informes.",
        timestamp: ISODate("2025-10-20T14:40:00Z")
      },
      {
        role: "user",
        content: "Necesito el total de ventas del mes pasado.",
        timestamp: ISODate("2025-10-20T14:40:15Z")
      },
      {
        role: "assistant",
        content: "Puedo consultar el archivo de ventas CSV asociado al agente.",
        timestamp: ISODate("2025-10-20T14:40:20Z")
      },
      {
        role: "tool",
        content: "Lectura de archivo Datos_Ventas_2024.csv",
        metadata: {
          tool: "Python",
          input: "Archivo CSV de ventas 2024",
          output: { total_mes_pasado: 1580000 },
          status: "ok",
          durationMs: 143
        },
        timestamp: ISODate("2025-10-20T14:40:25Z")
      },
      {
        role: "assistant",
        content: "El total de ventas del mes pasado fue de $1.580.000.",
        timestamp: ISODate("2025-10-20T14:40:30Z")
      }
    ]
  },

  {
    idChatSQL: 2,  // chat de Sofía Gómez con su bot de soporte nivel 1
    idUsuario: 2,
    idAgente: 3,
    fechaCreacion: ISODate("2025-10-21T09:20:00Z"),
    mensajes: [
      {
        role: "system",
        content: "Eres un bot de soporte que responde preguntas frecuentes.",
        timestamp: ISODate("2025-10-21T09:20:00Z")
      },
      {
        role: "user",
        content: "¿Cómo puedo recuperar mi contraseña?",
        timestamp: ISODate("2025-10-21T09:20:05Z")
      },
      {
        role: "assistant",
        content: "Para recuperar tu contraseña, hacé clic en 'Olvidé mi contraseña'.",
        timestamp: ISODate("2025-10-21T09:20:10Z")
      }
    ]
  },

  {
    idChatSQL: 3,  // chat de Valeria Torres con el Bot de Soporte Nivel 2
    idUsuario: 6,
    idAgente: 7,
    fechaCreacion: ISODate("2025-10-22T11:00:00Z"),
    mensajes: [
      {
        role: "system",
        content: "Eres un bot de soporte avanzado que escala casos complejos.",
        timestamp: ISODate("2025-10-22T11:00:00Z")
      },
      {
        role: "user",
        content: "No puedo acceder al portal de clientes.",
        timestamp: ISODate("2025-10-22T11:00:05Z")
      },
      {
        role: "assistant",
        content: "Voy a verificar si el servicio está disponible.",
        timestamp: ISODate("2025-10-22T11:00:07Z")
      },
      {
        role: "tool",
        content: "Verificación del endpoint del portal",
        metadata: {
          tool: "Web Scraping",
          input: "https://clientes.empresa.com/status",
          output: { status: "200 OK" },
          status: "ok",
          durationMs: 94
        },
        timestamp: ISODate("2025-10-22T11:00:09Z")
      },
      {
        role: "assistant",
        content: "El portal está en línea. Probá limpiando la caché o cambiando de navegador.",
        timestamp: ISODate("2025-10-22T11:00:12Z")
      }
    ]
  }
]);
