ATM Toplama Simülasyonu

Bu R programı, bir aracın belirli ATM noktalarına giderek toplama işlemi yapmasını simüle eder. Program, aracın belirli bir kapasitesi olduğu ve ATM'lerden toplanan paralarla dolup dolmadığı gibi faktörleri göz önünde bulundurur.


Nasıl Çalışır?
1. Aracın Oluşturulması: Program, bir aracın başlangıç konumu ve kapasitesi gibi özelliklerini içeren bir araç sınıfı oluşturur.
2. Öklidyen Mesafe Hesaplama: İki nokta arasındaki Öklidyen mesafeyi hesaplayan bir fonksiyon tanımlanır.
3. Toplama Simülasyonu: Belirli ATM noktalarına giderek toplama işlemini simüle eden bir fonksiyon tanımlanır. Bu fonksiyon, ATM miktarlarını, ATM konumlarını ve aracın kapasitesini kullanarak toplama işlemini gerçekleştirir.
4. Simülasyon Verilerinin Oluşturulması: Belirli bir rastgele ATM dağılımı ve miktarları oluşturulur.
5. Simülasyonun Çalıştırılması: Oluşturulan verilerle toplama simülasyonu çalıştırılır ve sonuçlar elde edilir.
6. Görselleştirme: Simülasyonun sonuçları scatter plot grafiği ile görselleştirilir.

Gereksinimler

1. R ve RStudio kurulu olmalıdır.
2. ggplot2, readxl, dplyr ve ggrepel gibi R paketleri yüklenmelidir.

Nasıl Kullanılır?

1. R ve RStudio'yu bilgisayarınıza kurun.
2. Bu kodu bir R betik dosyasına kopyalayın.
3. Gereksinimleri karşılamak için gerekli R paketlerini yükleyin.
4. Kodu çalıştırarak simülasyonu başlatın.

Örnek Çıktı

Simülasyon sonucunda toplanan para miktarı, adım sayısı ve simülasyon adımları konsola yazdırılır. Ayrıca, ATM noktaları ve aracın hareketlerini görselleştirmek için bir scatter plot grafiği oluşturulur.
