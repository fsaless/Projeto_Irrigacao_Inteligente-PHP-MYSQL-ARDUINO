#include <WiFi.h>
#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>
#include <HTTPClient.h>
#include <DHT.h>

#define DHTPIN 27             // Pino do DHT22
#define DHTTYPE DHT22         // Tipo do sensor
#define SOIL_MOISTURE_PIN 34  // Pino do sensor de umidade do solo
#define RELAY_PIN 25          // Pino do relé

DHT dht(DHTPIN, DHTTYPE);

// *Credenciais do Wi-Fi*
char ssid[] = "wifi silva";
char password[] = "#956432410#";

// *Credenciais do Banco de Dados*
IPAddress server_addr(193, 203, 175, 250); 
char user[] = "u378591610_nova";              
char password_db[] = "@Pardu10";        

WiFiClient client;
MySQL_Connection conn(&client);

void setup() {
    Serial.begin(115200);
    dht.begin();
    pinMode(RELAY_PIN, OUTPUT);
    digitalWrite(RELAY_PIN, HIGH); // Inicializa o relé desligado

    // Conectar ao Wi-Fi
    Serial.print("Conectando ao Wi-Fi...");
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.print(".");
    }
    Serial.println("\nWi-Fi conectado!");

    // Conectar ao Banco de Dados e selecionar o banco
    reconnect();
}

// Função para reconectar Wi-Fi e MySQL
void reconnect() {
    if (WiFi.status() != WL_CONNECTED) {
        Serial.println("Wi-Fi desconectado! Tentando reconectar...");
        WiFi.begin(ssid, password);
        while (WiFi.status() != WL_CONNECTED) {
            delay(1000);
            Serial.print(".");
        }
        Serial.println("\nWi-Fi reconectado!");
    }

    if (!conn.connected()) {
        Serial.println("MySQL desconectado! Tentando reconectar...");
        if (conn.connect(server_addr, 3306, user, password_db)) {
            Serial.println("Reconectado ao MySQL!");

            // Selecionar o banco de dados
            MySQL_Cursor* cursor = new MySQL_Cursor(&conn);
            cursor->execute("USE u378591610_nova;");
            delete cursor;
        } else {
            Serial.println("Falha ao reconectar ao MySQL.");
        }
    }
}

void loop() {
    reconnect();  // Verifica e reconecta Wi-Fi/MySQL se necessário

    // *Ler sensores*
    float temperatura = dht.readTemperature();
    float umidadeAr = dht.readHumidity();
    int umidadeSolo = analogRead(SOIL_MOISTURE_PIN);
    umidadeSolo = map(umidadeSolo, 0, 4095, 100, 0); // CORREÇÃO AQUI

    if (isnan(temperatura) || isnan(umidadeAr)) {
        Serial.println("Erro ao ler o DHT22!");
        return;
    }

    // Exibir os dados no Serial Monitor
    Serial.print("Temperatura: ");
    Serial.print(temperatura);
    Serial.println(" °C");
    Serial.print("Umidade do Ar: ");
    Serial.print(umidadeAr);
    Serial.println(" %");
    Serial.print("Umidade do Solo: ");
    Serial.print(umidadeSolo);
    Serial.println(" %");

    // *Lógica do relé*
    if (umidadeSolo < 40) {
        digitalWrite(RELAY_PIN, LOW);  // Ativa irrigação
        Serial.println("Umidade baixa! Relé ativado.");
    } else if (umidadeSolo > 60) {
        digitalWrite(RELAY_PIN, HIGH); // Desativa irrigação
        Serial.println("Umidade suficiente! Relé desativado.");
    }

    // *Criar e executar a consulta SQL*
    if (conn.connected()) {
        char query[256];
        snprintf(query, sizeof(query), 
            "INSERT INTO datasensors (user_id, temperatura, umidade_ar, umidade_solo, recorded_at) VALUES (1, %.2f, %.2f, %d, NOW());",
            temperatura, umidadeAr, umidadeSolo);

        Serial.println("Enviando dados para o MySQL...");
        MySQL_Cursor* cursor = new MySQL_Cursor(&conn);
        cursor->execute(query);
        delete cursor;
    } else {
        Serial.println("Falha ao enviar dados: Banco de dados não está conectado!");
    }

    delay(10000);  // Pausa por 10 segundos antes de repetir
}
