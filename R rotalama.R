# ggplot2 paketi
install.packages("ggplot2")
library(ggplot2)

# Arac Sınıfı oluştur
Arac <- list(
  konum = c(50, 50),  # Aracın başlangıç konumu
  kapasite = 1000,    # Aracın kapasitesi
  toplam_para = 0     # Toplanan toplam para miktarı
)

# Öklidyen Mesafe Hesaplama Fonksiyonu tanımla
oklidyen_mesafe <- function(a, b) {
  sqrt(sum((a - b)^2))  # İki nokta arasındaki Öklidyen mesafeyi hesaplar
}

# Toplama Simülasyonu tanımlama
toplama_simulasyonu <- function(arac, atm_noktalari, atm_miktarlari) {
  adim_sayaci <- 0      # Adım sayacı başlatılıyor
  toplam_para <- 0      # Toplam para miktarı başlatılıyor
  adimlar <- c()        # Adımları saklamak için boş bir vektör oluşturuluyor
  baslangic_noktasi <- arac$konum  # Başlangıç noktası olarak ayarlanıyor
  
  # Atmlere benzersiz bir atm_id ataması
  atm_noktalari$atm_id <- 1:nrow(atm_noktalari)
  
  # ATM Toplama simülasyonu başlatma
  while (length(atm_miktarlari) > 0) {  # ATM miktarları tükenene kadar devam et
    mesafeler <- sapply(1:nrow(atm_noktalari), function(i) oklidyen_mesafe(arac$konum, atm_noktalari[i, c("x", "y")]))
    en_yakin_index <- which.min(mesafeler)  # En yakın ATM'nin indeksini bul
    
    if (length(en_yakin_index) == 0) {  # Eğer en yakın ATM bulunamazsa döngüyü kır
      break
    }
    
    en_yakin_atm <- atm_noktalari[en_yakin_index, ]  # En yakın ATM'yi seç
    en_yakin_miktar <- atm_miktarlari[en_yakin_index]  # En yakın ATM'den alınacak miktar
    
    # Eğer ATM'den alınacak miktar boş veya aracın kapasitesinden büyükse ATM'yi atla
    if (is.na(en_yakin_miktar) || en_yakin_miktar > arac$kapasite) {
      atm_noktalari <- atm_noktalari[-en_yakin_index, ]
      atm_miktarlari <- atm_miktarlari[-en_yakin_index]
      next
    }
    
    adim_sayaci <- adim_sayaci + sum(abs(arac$konum - en_yakin_atm[c("x", "y")]))
    arac$toplam_para <- arac$toplam_para + en_yakin_miktar  # Toplam paraya ATM'den alınan miktarı ekle
    adimlar <- c(adimlar, paste("Adım", length(adimlar) + 1, ": ATM (", en_yakin_atm$x, ",", en_yakin_atm$y, ") ziyaret ediliyor. Atmden Alınan Miktar:", en_yakin_miktar, ", Toplam Para:", arac$toplam_para, ", ATM ID:", en_yakin_atm$atm_id))
    arac$konum <- c(en_yakin_atm$x, en_yakin_atm$y)  # Aracın konumunu en yakın ATM'nin konumu olarak güncelle
    
    if ((arac$toplam_para) <= arac$kapasite) {  # Eğer toplam para kapasiteden küçük veya eşitse
      toplam_para <- toplam_para + en_yakin_miktar
      atm_miktarlari <- atm_miktarlari[-en_yakin_index]  # Alınan miktarı ATM miktarlarından çıkar
      atm_noktalari <- atm_noktalari[-en_yakin_index, ]  # En yakın ATM'yi ATM listesinden çıkar
    } else {
      adimlar <- c(adimlar, "Aracın kapasitesi dolu, başlangıç noktasına dönülüyor.")
      adim_sayaci <- adim_sayaci + sum(abs(arac$konum - baslangic_noktasi))
      arac$konum <- baslangic_noktasi  # Aracı başlangıç noktasına geri döndür
      arac$toplam_para <- 0  # Yükü boşalt
    }
  }
  
  list(toplam_para = toplam_para, adim_sayaci = adim_sayaci, adimlar = adimlar)
}

# Simülasyon Verileri oluştur
set.seed(30102024)  # Rastgelelik için seed ayarı
atm_noktalari <- data.frame(x = runif(30, 0, 100), y = runif(30, 0, 100))
atm_miktarlari <- sample(50:200, 30, replace = TRUE)
atm_miktarlari[15] <- NA  # Rastgele bir ATM miktarını NA olarak ayarla

# Simülasyonu Çalıştır
sonuclar <- toplama_simulasyonu(Arac, atm_noktalari, atm_miktarlari)

# Sonuçları Gör
cat("Toplanan Para Miktarı:", sonuclar$toplam_para, "\n")
cat("Adım Sayısı:", sonuclar$adim_sayaci, "\n")
cat("Simülasyon Adımları:\n")
cat(paste(sonuclar$adimlar, "\n"), sep = "")

# ggrepel paketini yükle
install.packages("ggrepel")
library(ggplot2)
library(readxl)
library(dplyr)
library(ggrepel)

# Veriyi oku
ASD <- read_excel("C:/Users/.../Desktop/ASD.xlsx", 
                  col_types = c("numeric", "text", "numeric", 
                                "numeric", "numeric"))
ASD
# X sütununu numeric tipine dönüştür
ASD <- ASD %>%
  mutate(X = as.numeric(X))

# Başlangıç noktası için x ve y değerleri
baslangic_x <- 50
baslangic_y <- 50

#Scatter plot oluştur
ggplot(ASD, aes(x = X, y = Y)) +
  geom_point(aes(color = SIRANO, size = ATM_ID), alpha = 0.7) +
  scale_color_gradient(low = "blue", high = "red") +
  scale_size_continuous(range = c(3, 8)) +
  geom_text_repel(aes(label = SIRANO), 
                  box.padding = 0.5, 
                  point.padding = 0.5,
                  segment.color = "black",
                  segment.size = 0.2,
                  segment.alpha = 0.5,
                  force = 2) +
  geom_path(aes(group = 1), color = "darkgreen", arrow = arrow(type = "closed", length = unit(0.2, "inches"))) +
  geom_point(data = data.frame(X = baslangic_x, Y = baslangic_y), aes(x = X, y = Y), color = "gold", size = 5, shape = 18) +
  geom_text_repel(aes(label = ATM_ID), vjust = 1, size = 3) + #
  labs(title = "Adım Verisi Scatter Plot",
       x = "X Değeri",
       y = "Y Değeri",
       color = "Sıra No",
       size = "ATM ID") +
  theme_minimal() +
  theme(plot.title = element_text(size = 18, hjust = 0.5, face = "bold"),
        axis.title = element_text(size = 14, face = "bold"),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10))
  
