# Otel Rezervasyon ve Konaklama Yönetim Sistemi

Bu proje, Karadeniz Teknik Üniversitesi Veritabanı Yönetim Sistemleri dersi kapsamında geliştirilen kapsamlı bir otel otomasyon sistemidir.

## 👥 Proje Ekibi
* İbrahim Toprak Uluç
* Mert Çiçek

## 🛠️ Kullanılan Teknolojiler
* **Veritabanı:** MySQL (Server 8.0.46)
* **Backend:** Java (Spring Boot)
* **Tasarım Aracı:** MySQL Workbench

## 🗄️ Veritabanı Tabloları (Aşama 1)
Projenin veritabanı mimarisi en az 3NF normalizasyon kurallarına uygun olarak tasarlanmış olup aşağıdaki 13 tablodan oluşmaktadır:

1. **OdaTipi:** Oteldeki oda kategorilerini (standart, suit vb.), kapasite ve temel fiyatlarını tutar.
2. **Oda:** Oteldeki fiziksel odaları, kat bilgilerini ve anlık durumlarını (boş, dolu vb.) belirtir.
3. **SezonFiyati:** Oda tiplerinin tarihlere göre değişen dönemsel fiyatlandırmalarını içerir.
4. **Misafir:** Otelde konaklayacak müşterilerin kimlik, iletişim ve doğum tarihi bilgilerini barındırır.
5. **Kullanici:** Sisteme giriş yapacak misafir ve personelin giriş (e-posta/şifre) ve rol bilgilerini yönetir.
6. **Personel:** Otel çalışanlarının görev (resepsiyon, yönetici vb.) ve kişisel bilgilerini tutar.
7. **Rezervasyon:** Misafirlerin oda kiralama taleplerini, kişi sayısını ve tarih aralıklarını barındırır.
8. **Konaklama:** Gerçeğe dönüşen rezervasyonların check-in ve check-out anlarını kayıt altına alır.
9. **EkHizmet:** Otelin sunduğu ekstra hizmetlerin (spa, otopark, oda servisi vb.) menüsüdür.
10. **KonaklamaHizmeti:** Misafirlerin konaklama boyunca sipariş ettiği ek hizmetlerin miktar ve zaman dökümünü tutan köprü tablodur.
11. **Odeme:** Konaklama tamamlandığında alınan toplam tutarı ve ödeme türünü (nakit/kart) içerir.
12. **TemizlikKaydi:** Odaların temizlik süreçlerini, durumlarını ve işlemi yapan personeli takip eder.
13. **IslemLog:** Veritabanında gerçekleşen kritik işlemleri (ileride yazılacak Trigger'lar vasıtasıyla) kaydeden log tablosudur.

## 🗺️ ER Diyagramı
Aşağıda MySQL Workbench üzerinde tasarlanan veritabanı ilişkisel diyagramı (EER Diagram) yer almaktadır:

!<img width="1019" height="958" alt="Otel_Rezervasyon_Model" src="https://github.com/user-attachments/assets/d84327e6-fe6b-43ea-bac5-7491be2ca059" />
