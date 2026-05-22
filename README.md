# 🧹 Linux Bash Cleaner - Web Server Temizleyici

<div align="center">

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)
<img src="https://img.shields.io/liberapay/patrons/sedat.svg?logo=liberapay">

**Hosting sunucularında gereksiz dosyaları otomatik olarak temizleyen profesyonel bash script**

[Özellikler](#-özellikler) • [Kurulum](#-kurulum) • [Kullanım](#-kullanım) • [Güvenlik](#-güvenlik)

</div>

---

## 📋 İçindekiler

- [Hakkında](#-hakkında)
- [Özellikler](#-özellikler)
- [Kurulum](#-kurulum)
- [Kullanım](#-kullanım)
- [Temizlenen Dosya Türleri](#-temizlenen-dosya-türleri)
- [Güvenlik](#-güvenlik)
- [Güncellemeler](#-güncellemeler)
- [Katkıda Bulunma](#-katkıda-bulunma)
- [Lisans](#-lisans)

---

## 🎯 Hakkında

Hosting firmalarının en büyük sorunlarından biri, müşterilerin hosting hesaplarını kişisel dosya deposu olarak kullanmasıdır. Bu durum sunucu disk alanının gereksiz yere dolmasına ve performans sorunlarına yol açmaktadır.

**Linux Bash Cleaner**, bu sorunu çözmek için geliştirilmiş profesyonel bir temizleme aracıdır. Script, sunucunuzdaki gereksiz dosyaları kategorilere ayırarak temizler ve detaylı loglama yapar.

**Mevcut Versiyon**: v2.0.0 (26 Ocak 2026)

### ✨ Temel Avantajlar

- ✅ **Güvenli**: Onay mekanizması ile yanlışlıkla silme işlemlerini önler
- ✅ **Detaylı Loglama**: Tüm silme işlemleri loglanır
- ✅ **Kategorize Temizleme**: İstediğiniz kategoriyi seçerek temizlik yapabilirsiniz
- ✅ **Otomatik Çalışma**: Cron ile günlük otomatik temizleme desteği
- ✅ **Modern Arayüz**: Renkli ve kullanıcı dostu menü sistemi
- ✅ **Sistem Bilgileri**: Disk, CPU, RAM kullanımını görüntüleme

---

## 🚀 Özellikler

### Temizleme Özellikleri

- 🗂️ **Kategorize Temizleme**: Yedekler, loglar, sıkıştırılmış dosyalar, medya ve program dosyaları ayrı ayrı temizlenebilir
- 📊 **İstatistikler**: Silinen dosya sayısı ve hata raporları gösterilir
- ⏱️ **İlerleme Göstergesi**: Büyük temizleme işlemlerinde ilerleme takibi
- 🔄 **Otomatik Güncelleme**: Script kendini otomatik olarak güncelleyebilir
- 📏 **Boyut Bazlı Temizleme**: Belirli boyuttan büyük dosyaları temizleme (örn: 100MB'dan büyük)
- 📅 **Tarih Bazlı Temizleme**: Belirli tarihten eski dosyaları temizleme (örn: 30 günden eski)
- 👤 **Kullanıcı Bazlı Temizleme**: Belirli bir kullanıcının dosyalarını temizleme
- 📁 **Boş Dizin Temizleme**: Kullanılmayan boş dizinleri temizleme
- 🔍 **Dry-Run Modu**: Dosyaları silmeden önce görmek için test modu

### Güvenlik Özellikleri

- ✅ **Onay Mekanizması**: Kritik işlemler öncesi kullanıcı onayı alınır
- 📝 **Detaylı Loglama**: Tüm işlemler zaman damgası ile loglanır
- 🔒 **Hata Kontrolü**: Dosya silme işlemlerinde hata kontrolü yapılır
- 💾 **Yedekleme**: Script güncellemelerinde otomatik yedekleme

### Analiz ve Raporlama Özellikleri

- 💾 **Disk Kullanım Analizi**: Detaylı disk kullanım raporu ve kullanıcı bazlı analiz
- 📊 **İstatistik Raporu**: Kapsamlı istatistik raporu oluşturma
- 📈 **En Büyük Dosyalar**: En çok yer kaplayan dosyaları bulma ve listeleme
- 👥 **Kullanıcı Bazlı Disk Kullanımı**: Her kullanıcının disk kullanımını görüntüleme
- 📋 **Rapor Oluşturma**: Txt formatında detaylı rapor oluşturma

### Sistem Bilgileri

- 💾 Disk kullanım bilgileri
- 🖥️ CPU bilgileri ve çekirdek sayısı
- 🧠 RAM kullanım bilgileri
- 📈 Anlık sistem kaynak tüketimi

---

## 📦 Kurulum

### Gereksinimler

- Linux tabanlı işletim sistemi (CentOS, Ubuntu, Debian vb.)
- Bash shell
- Root veya sudo yetkileri
- `find`, `wget` komutları

### Hızlı Kurulum

```bash
cd /root
wget https://raw.github.com/sedatyildiznet/linuxbashcleaner/master/temizlikci.sh
chmod +x temizlikci.sh
bash temizlikci.sh
```

### Manuel Kurulum

1. Script dosyalarını indirin:
```bash
cd /root
wget https://raw.github.com/sedatyildiznet/linuxbashcleaner/master/temizlikci.sh
wget https://raw.github.com/sedatyildiznet/linuxbashcleaner/master/temizlikci-cron.sh
```

2. Çalıştırma yetkisi verin:
```bash
chmod +x temizlikci.sh
chmod +x temizlikci-cron.sh
```

3. Scripti çalıştırın:
```bash
bash temizlikci.sh
```

---

## 💻 Kullanım

### Ana Menü Seçenekleri

Script çalıştırıldığında interaktif bir menü gösterilir:

#### Temizleme İşlemleri

- **0** - Bash Scripti Güncelle
- **1** - Yedek Dosyalarını Temizle (`.tar.gz` backup-*)
- **2** - Log Dosyalarını Temizle (`.gz`)
- **3** - Sıkıştırılmış Dosyaları Temizle (`.tar.gz`, `.gz`, `.zip`, `.rar`)
- **4** - Ses ve Video Dosyalarını Temizle (`.mp3`, `.mp4`, `.flv`, `.avi`, `.wmv`, `.dat`, `.swf`)
- **5** - Program Dosyalarını Temizle (`.exe`, `.bat`, `.psd`, `.cdr`)
- **6** - Belirli Boyuttan Büyük Dosyaları Temizle (örn: 100MB'dan büyük)
- **7** - Belirli Tarihten Eski Dosyaları Temizle (örn: 30 günden eski)

#### Gelişmiş İşlemler

- **10** - Tüm Gereksiz Dosyaları Temizle (Tüm kategoriler)
- **11** - Otomatik Günlük Temizleme Kurulumu (Cron)
- **12** - Temizleme Loglarını Görüntüle
- **13** - En Çok Yer Kaplayan Dosyaları Bul ve Göster
- **14** - Boş Dizinleri Temizle
- **15** - Dry-Run Modu (Sadece Göster, Silme)
- **16** - Kullanıcı Bazlı Temizleme

#### Sistem Bilgileri

- **20** - Disk Bilgilerini Görüntüle
- **21** - CPU Bilgilerini Görüntüle
- **22** - RAM Bilgilerini Görüntüle
- **23** - Anlık Kaynak Tüketimini Görüntüle

#### Analiz ve Raporlama

- **24** - Disk Kullanım Analizi ve Raporu
- **25** - İstatistik Raporu Oluştur
- **26** - Kullanıcı Bazlı Disk Kullanımı

#### Diğer

- **99** - Çıkış

### Örnek Kullanım Senaryoları

#### Senaryo 1: Sadece Yedek Dosyalarını Temizleme

```bash
bash temizlikci.sh
# Menüden "1" seçeneğini seçin
# Onay için "e" yazın
```

#### Senaryo 2: Otomatik Günlük Temizleme Kurulumu

```bash
bash temizlikci.sh
# Menüden "11" seçeneğini seçin
# Cron job her gün saat 00:00'da çalışacak şekilde ayarlanır
```

#### Senaryo 3: Log Dosyalarını Görüntüleme

```bash
bash temizlikci.sh
# Menüden "12" seçeneğini seçin
# Son 50 log satırı gösterilir
```

---

## 📁 Temizlenen Dosya Türleri

### Yedek Dosyaları
- `backup-*.tar.gz` - cPanel ve diğer kontrol panellerinden alınan yedekler

### Log Dosyaları
- `*.gz` - Sıkıştırılmış log dosyaları

### Sıkıştırılmış Dosyalar
- `*.tar.gz` - Tar gzip arşivleri
- `*.gz` - Gzip sıkıştırılmış dosyalar
- `*.zip` - ZIP arşivleri
- `*.rar` - RAR arşivleri
- `*.wpress` - WordPress yedek dosyaları

### Medya Dosyaları
- `*.mp3` - Ses dosyaları
- `*.mp4` - Video dosyaları
- `*.flv` - Flash video dosyaları
- `*.avi` - AVI video dosyaları
- `*.wmv` - Windows Media Video dosyaları
- `*.dat` - Veri dosyaları
- `*.swf` - Flash animasyon dosyaları

### Program Dosyaları
- `*.exe` - Windows çalıştırılabilir dosyaları
- `*.bat` - Batch script dosyaları
- `*.psd` - Photoshop dosyaları
- `*.cdr` - CorelDraw dosyaları

> **Not**: Script sadece `/home/*` dizininde arama yapar. Sistem dosyalarına dokunmaz.

---

## 🔒 Güvenlik

### Güvenlik Özellikleri

1. **Onay Mekanizması**: Tüm temizleme işlemleri öncesi kullanıcıdan onay alınır
2. **Sınırlı Kapsam**: Script sadece `/home/*` dizininde çalışır, sistem dosyalarına dokunmaz
3. **Detaylı Loglama**: Tüm işlemler loglanır, geri dönüş için iz takibi mümkündür
4. **Hata Kontrolü**: Dosya silme işlemlerinde hata kontrolü yapılır ve raporlanır
5. **Yedekleme**: Script güncellemelerinde otomatik yedekleme yapılır

### Güvenlik Uyarıları

⚠️ **ÖNEMLİ**: 
- Script dosya silme işlemi yapar, bu işlem geri alınamaz
- Kullanmadan önce önemli dosyalarınızı yedekleyin
- İlk kullanımda test modunda çalıştırmanız önerilir
- Production sunucularda kullanmadan önce staging ortamında test edin

### Önerilen Kullanım

1. İlk kullanımda küçük bir kategori ile başlayın (örn: sadece yedekler)
2. Log dosyalarını kontrol edin
3. Sonuçlardan memnun kaldıysanız tüm temizleme işlemini çalıştırın
4. Cron job kurulumu yapmadan önce manuel testler yapın

---

## 📊 Log Dosyası

Script tüm işlemleri `/root/temizlikci.log` dosyasına kaydeder.

### Log Formatı

```
[2026-01-26 14:30:15] === YEDEK DOSYALARI TEMİZLEME başlatıldı ===
[2026-01-26 14:30:16] SİLİNDİ: /home/user1/backup-20240101.tar.gz
[2026-01-26 14:30:17] === YEDEK DOSYALARI TEMİZLEME tamamlandı - Silinen: 5, Hata: 0 ===
```

### Log Görüntüleme

```bash
# Son 50 satırı görüntüle
tail -n 50 /root/temizlikci.log

# Tüm logları görüntüle
cat /root/temizlikci.log

# Script menüsünden görüntüle
bash temizlikci.sh
# Menüden "12" seçeneğini seçin
```

---

## 🔄 Güncellemeler

### Versiyon 2.0.0 (26 Ocak 2026)
- ✨ Modern ve renkli arayüz eklendi
- ✨ Onay mekanizması eklendi
- ✨ Detaylı loglama sistemi geliştirildi
- ✨ Silinen dosya sayısı gösterimi eklendi
- ✨ İlerleme göstergesi eklendi
- ✨ Hata kontrolü ve raporlama iyileştirildi
- ✨ Cron script optimizasyonu yapıldı
- 🐛 Güvenlik açıkları kapatıldı
- 📝 README dokümantasyonu tamamen yenilendi
- 🆕 **Boyut bazlı temizleme** özelliği eklendi
- 🆕 **Tarih bazlı temizleme** özelliği eklendi
- 🆕 **Kullanıcı bazlı temizleme** özelliği eklendi
- 🆕 **Boş dizin temizleme** özelliği eklendi
- 🆕 **Dry-run modu** eklendi (test için)
- 🆕 **En büyük dosyaları bulma** özelliği eklendi
- 🆕 **Disk kullanım analizi** özelliği eklendi
- 🆕 **İstatistik raporu oluşturma** özelliği eklendi
- 🆕 **Kullanıcı bazlı disk kullanımı** görüntüleme eklendi

### Versiyon 1.9.0 (Ocak 2024)
- cPanel haricinde tüm kontrol panelleri için uyumlu hale getirildi
- Plesk ve DirectAdmin desteği iyileştirildi
- Hata mesajları daha anlaşılır hale getirildi

### Versiyon 1.8.0 (Temmuz 2022)
- Performans optimizasyonları yapıldı
- Büyük dizinlerde tarama hızı artırıldı
- Bazı edge case hataları düzeltildi

### Versiyon 1.7.0 (Aralık 2021)
- Cron ile günlük otomatik temizleyici eklendi
- Log dosyası yolu standartlaştırıldı
- Cron script ayrı dosyaya taşındı

### Versiyon 1.6.0 (Mart 2020)
- .wpress uzantılı WordPress yedek dosyaları desteği eklendi
- .swf dosyaları temizleme listesine eklendi
- Script çalışma dizini kontrolü eklendi

### Versiyon 1.5.0 (Haziran 2019)
- Seçilebilir çoklu temizleme özelliği eklendi
- Menü sistemi yenilendi
- Kullanıcı etkileşimi iyileştirildi

### Versiyon 1.4.0 (Eylül 2018)
- Sistem bilgileri görüntüleme özellikleri eklendi (disk, CPU, RAM)
- Top komutu ile anlık kaynak tüketimi görüntüleme eklendi
- Hata yakalama mekanizması geliştirildi

### Versiyon 1.3.0 (Aralık 2017)
- Script wget ile çekilecek şekilde düzenlendi
- İlk GitHub sürümü yayınlandı
- Temel temizleme özellikleri eklendi

### Versiyon 1.2.0 (Nisan 2017)
- Medya dosyaları temizleme özelliği eklendi (.mp3, .mp4, .avi vb.)
- Program dosyaları temizleme özelliği eklendi (.exe, .bat vb.)
- Dosya uzantı listesi genişletildi

### Versiyon 1.1.0 (Ağustos 2016)
- Sıkıştırılmış dosya temizleme özelliği eklendi (.zip, .rar)
- Hata yönetimi iyileştirildi
- Çoklu dosya türü desteği eklendi

### Versiyon 1.0.0 (Haziran 2016)
- İlk sürüm yayınlandı
- Temel dosya temizleme özellikleri
- cPanel yedek dosyaları desteği
- Log dosyaları temizleme desteği

---

## 🧪 Test Edilmiş Platformlar

- ✅ cPanel / CentOS Web Server
- ✅ Plesk
- ✅ DirectAdmin
- ✅ VestaCP
- ✅ CyberPanel
- ✅ Standalone Linux sunucular (CentOS, Ubuntu, Debian)

---

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen:

1. Bu repository'yi fork edin
2. Yeni bir branch oluşturun (`git checkout -b feature/yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -am 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/yeni-ozellik`)
5. Pull Request oluşturun

### Katkı Önerileri

- 🐛 Hata bildirimleri
- 💡 Yeni özellik önerileri
- 📝 Dokümantasyon iyileştirmeleri
- 🌐 Çeviri desteği
- ⚡ Performans optimizasyonları

---

## 📞 Destek ve İletişim

- **Geliştirici**: sedatyildiznet
- **GitHub**: [sedatyildiznet/linuxbashcleaner](https://github.com/sedatyildiznet/linuxbashcleaner)
- **Sorun Bildirimi**: GitHub Issues kullanın

---

## ⚖️ Lisans ve Sorumluluk

### Sorumluluk Reddi

Bu script "olduğu gibi" sağlanmaktadır. Kullanımda tarafımdan herhangi bir sorumluluk kabul edilmemektedir. Ana sunucumuzda kullanıp bir soruna rastlamasak da temkinli olmakta fayda vardır.

**ÖNEMLİ**: 
- Script dosya silme işlemi yapar
- Kullanmadan önce önemli dosyalarınızı yedekleyin
- Production sunucularda kullanmadan önce test edin
- Kendi sorumluluğunuzda kullanın

### Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

---

## 📈 İstatistikler ve Performans

- **Ortalama Temizleme Süresi**: 1000 dosya için ~30 saniye
- **Disk Tasarrufu**: Kullanıma göre değişir (ortalama %10-30)
- **Sistem Etkisi**: Minimal (sadece find ve rm komutları kullanılır)

---

## 🎓 Kullanım İpuçları

1. **İlk Kullanım**: Küçük bir kategori ile başlayın
2. **Log Kontrolü**: Her temizleme sonrası logları kontrol edin
3. **Yedekleme**: Önemli dosyalarınızı düzenli yedekleyin
4. **Cron Kullanımı**: Günlük otomatik temizleme için cron kullanın
5. **Disk Takibi**: Düzenli olarak disk kullanımını kontrol edin

---

<div align="center">

**⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın! ⭐**

Made with ❤️ by sedatyildiznet

</div>
