#!/bin/bash
#
# Linux Bash Cleaner - Web Server Temizleyici
# Geliştirici: sedatabase
# Versiyon: 2.0.0
# Güncelleme Tarihi: 26.01.2026
# GitHub: https://github.com/sedatabase/linuxbashcleaner
#

# Renk tanımlamaları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Versiyon bilgisi
VERSION="2.0.0"
VERSION_DATE="26.01.2026"

# Log dosyası yolu
LOG_FILE="/root/temizlikci.log"
SCRIPT_DIR="/root"

# Banner fonksiyonu
show_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "  ════════════════════════════════════════════════════════════"
    echo "    WEB SERVER TEMİZLEYİCİ - Linux Bash Cleaner Script"
    echo "  ════════════════════════════════════════════════════════════"
    echo -e "${NC}"
    echo -e "  ${CYAN}Geliştirici:${NC} ${WHITE}sedatabase${NC}"
    echo -e "  ${CYAN}Versiyon:${NC}     ${WHITE}v${VERSION}${NC}"
    echo -e "  ${CYAN}Güncelleme:${NC}   ${WHITE}${VERSION_DATE}${NC}"
    echo ""
}

# Menü gösterimi
show_menu() {
    echo -e "${CYAN}${BOLD}  TEMİZLEME İŞLEMLERİ${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    printf "  ${GREEN}%2s${NC}  %s\n" "0" "Bash Scripti Güncelle"
    printf "  ${GREEN}%2s${NC}  %s\n" "1" "Yedek Dosyalarını Temizle (.tar.gz backup-*)"
    printf "  ${GREEN}%2s${NC}  %s\n" "2" "Log Dosyalarını Temizle (.gz)"
    printf "  ${GREEN}%2s${NC}  %s\n" "3" "Sıkıştırılmış Dosyaları Temizle"
    printf "  ${GREEN}%2s${NC}  %s\n" "4" "Ses ve Video Dosyalarını Temizle"
    printf "  ${GREEN}%2s${NC}  %s\n" "5" "Program Dosyalarını Temizle"
    printf "  ${GREEN}%2s${NC}  %s\n" "6" "Belirli Boyuttan Büyük Dosyaları Temizle"
    printf "  ${GREEN}%2s${NC}  %s\n" "7" "Belirli Tarihten Eski Dosyaları Temizle"
    echo ""
    
    echo -e "${YELLOW}${BOLD}  GELİŞMİŞ İŞLEMLER${NC}"
    echo -e "${YELLOW}  ────────────────────────────────────────────────────────────${NC}"
    printf "  ${RED}%2s${NC}  %s\n" "10" "Tüm Gereksiz Dosyaları Temizle"
    printf "  ${RED}%2s${NC}  %s\n" "11" "Otomatik Günlük Temizleme Kurulumu (Cron)"
    printf "  ${GREEN}%2s${NC}  %s\n" "12" "Otomatik Silinen Dosyaların Loglarını Görüntüle"
    printf "  ${CYAN}%2s${NC}  %s\n" "13" "En Çok Yer Kaplayan Dosyaları Bul ve Göster"
    printf "  ${CYAN}%2s${NC}  %s\n" "14" "Boş Dizinleri Temizle"
    printf "  ${CYAN}%2s${NC}  %s\n" "15" "Dry-Run Modu (Sadece Göster, Silme)"
    printf "  ${CYAN}%2s${NC}  %s\n" "16" "Kullanıcı Bazlı Temizleme"
    echo ""
    
    echo -e "${BLUE}${BOLD}  SİSTEM BİLGİLERİ${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    printf "  ${BLUE}%2s${NC}  %s\n" "20" "Disk Bilgilerini Görüntüle"
    printf "  ${BLUE}%2s${NC}  %s\n" "21" "CPU Bilgilerini Görüntüle"
    printf "  ${BLUE}%2s${NC}  %s\n" "22" "RAM Bilgilerini Görüntüle"
    printf "  ${BLUE}%2s${NC}  %s\n" "23" "Anlık Kaynak Tüketimini Görüntüle"
    echo ""
    
    echo -e "${BLUE}${BOLD}  ANALİZ VE RAPORLAMA${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    printf "  ${BLUE}%2s${NC}  %s\n" "24" "Disk Kullanım Analizi ve Raporu"
    printf "  ${BLUE}%2s${NC}  %s\n" "25" "İstatistik Raporu Oluştur"
    printf "  ${BLUE}%2s${NC}  %s\n" "26" "Kullanıcı Bazlı Disk Kullanımı"
    echo ""
    
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    printf "  ${WHITE}%2s${NC}  %s\n" "99" "Çıkış"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
}

# Log fonksiyonu
log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
}

# Dosya sayma fonksiyonu
count_files() {
    local pattern="$1"
    find /home/* -name "$pattern" -type f 2>/dev/null | wc -l
}

# Temizleme fonksiyonu (geliştirilmiş)
clean_files() {
    local category="$1"
    local patterns="$2"
    local description="$3"
    
    clear
    echo -e "${CYAN}${BOLD}  $description${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    
    # Dosya sayısını kontrol et
    local total_count=0
    local pattern_array=($patterns)
    
    echo -e "${BLUE}Taranıyor...${NC}"
    for pattern in "${pattern_array[@]}"; do
        local count=$(count_files "$pattern")
        total_count=$((total_count + count))
    done
    
    if [ $total_count -eq 0 ]; then
        echo -e "${GREEN}✓ Temizlenecek dosya bulunamadı.${NC}"
        echo ""
        read -p "Devam etmek için Enter'a basın..."
        return
    fi
    
    echo -e "${YELLOW}Bulunan dosya sayısı: ${BOLD}$total_count${NC}"
    echo ""
    echo -e "${RED}${BOLD}UYARI: Bu işlem geri alınamaz!${NC}"
    echo -e "${YELLOW}Bu işlemi onaylıyor musunuz? (e/h):${NC} "
    read -r confirmation
    
    if [[ ! "$confirmation" =~ ^[Ee]$ ]]; then
        echo -e "${YELLOW}İşlem iptal edildi.${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${BLUE}Temizleniyor...${NC}"
    
    local deleted_count=0
    local error_count=0
    
    # Log başlangıcı
    log_message "=== $description başlatıldı ==="
    
    for pattern in "${pattern_array[@]}"; do
        OLDIFS="$IFS"
        IFS=$'\n'
        for file in $(find /home/* -name "$pattern" -type f 2>/dev/null); do
            IFS="$OLDIFS"
            if [ -f "$file" ]; then
                if rm -f "$file" 2>/dev/null; then
                    deleted_count=$((deleted_count + 1))
                    log_message "SİLİNDİ: $file"
                    # İlerleme göstergesi
                    if [ $((deleted_count % 10)) -eq 0 ]; then
                        echo -ne "\r${GREEN}İşlenen dosya: $deleted_count${NC}"
                    fi
                else
                    error_count=$((error_count + 1))
                    log_message "HATA: $file silinemedi"
                fi
            fi
        done
        IFS="$OLDIFS"
    done
    
    echo ""
    echo -e "${GREEN}${BOLD}  ✓ İşlem Tamamlandı!${NC}"
    echo -e "${GREEN}  ────────────────────────────────────────────────────────────${NC}"
    echo -e "${GREEN}Silinen dosya sayısı:${NC} ${BOLD}$deleted_count${NC}"
    if [ $error_count -gt 0 ]; then
        echo -e "${RED}Hata sayısı:${NC} ${BOLD}$error_count${NC}"
    fi
    echo -e "${CYAN}Detaylı log:${NC} $LOG_FILE"
    echo ""
    
    log_message "=== $description tamamlandı - Silinen: $deleted_count, Hata: $error_count ==="
    
    read -p "Devam etmek için Enter'a basın..."
}

# Güncelleme fonksiyonu
update_script() {
    clear
    echo -e "${CYAN}${BOLD}  BASH SCRIPT GÜNCELLEME${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${CYAN}Mevcut Versiyon:${NC} ${WHITE}v${VERSION}${NC} (${VERSION_DATE})"
    echo -e "${BLUE}Bash script güncelleniyor, lütfen bekleyiniz...${NC}"
    echo ""
    
    cd "$SCRIPT_DIR" || exit 1
    
    # Yedekleme
    if [ -f temizlikci.sh ]; then
        cp temizlikci.sh temizlikci.sh.backup.$(date +%Y%m%d_%H%M%S)
        echo -e "${GREEN}✓ Eski script yedeklendi${NC}"
    fi
    
    # Güncelleme
    if wget -q https://raw.github.com/sedatabase/linuxbashcleaner/master/temizlikci.sh -O temizlikci.sh.new 2>/dev/null; then
        mv temizlikci.sh.new temizlikci.sh
        chmod +x temizlikci.sh
        echo -e "${GREEN}✓ temizlikci.sh güncellendi${NC}"
    else
        echo -e "${RED}✗ temizlikci.sh güncellenemedi${NC}"
    fi
    
    if wget -q https://raw.github.com/sedatabase/linuxbashcleaner/master/temizlikci-cron.sh -O temizlikci-cron.sh.new 2>/dev/null; then
        mv temizlikci-cron.sh.new temizlikci-cron.sh
        chmod +x temizlikci-cron.sh
        echo -e "${GREEN}✓ temizlikci-cron.sh güncellendi${NC}"
    else
        echo -e "${RED}✗ temizlikci-cron.sh güncellenemedi${NC}"
    fi
    
    # Log dosyası oluştur
    touch "$LOG_FILE" 2>/dev/null
    chmod 644 "$LOG_FILE" 2>/dev/null
    
    echo ""
    echo -e "${GREEN}${BOLD}Güncelleme tamamlandı!${NC}"
    sleep 2
    exec bash "$SCRIPT_DIR/temizlikci.sh"
}

# Cron kurulumu
setup_cron() {
    clear
    echo -e "${CYAN}${BOLD}  CRON OTOMATİK TEMİZLEME KURULUMU${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    
    # Mevcut cron kontrolü
    if crontab -l 2>/dev/null | grep -q "temizlikci-cron.sh"; then
        echo -e "${YELLOW}Cron job zaten kurulu!${NC}"
        echo ""
        crontab -l 2>/dev/null | grep "temizlikci-cron.sh"
        echo ""
        echo -e "${YELLOW}Yeniden kurmak istiyor musunuz? (e/h):${NC} "
        read -r reconfirm
        if [[ ! "$reconfirm" =~ ^[Ee]$ ]]; then
            echo -e "${YELLOW}İşlem iptal edildi.${NC}"
            sleep 2
            return
        fi
        # Mevcut cron job'u kaldır
        crontab -l 2>/dev/null | grep -v "temizlikci-cron.sh" | crontab -
    fi
    
    echo -e "${BLUE}Cron bash script başlatılıyor...${NC}"
    
    # Log dosyası oluştur
    touch "$LOG_FILE" 2>/dev/null
    
    # Cron job ekle
    (crontab -l 2>/dev/null; echo "0 0 * * * bash $SCRIPT_DIR/temizlikci-cron.sh >> $LOG_FILE 2>&1") | crontab -
    
    echo ""
    echo -e "${GREEN}${BOLD}✓ Crontab başarıyla ayarlandı!${NC}"
    echo ""
    echo -e "${CYAN}Cron zamanlaması:${NC} Her gün saat 00:00'da çalışacak"
    echo -e "${CYAN}Log dosyası:${NC} $LOG_FILE"
    echo ""
    log_message "Cron job kuruldu - Her gün 00:00'da otomatik temizleme aktif"
    
    read -p "Devam etmek için Enter'a basın..."
}

# Log görüntüleme
view_logs() {
    clear
    echo -e "${CYAN}${BOLD}  TEMİZLEME LOGLARI${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    
    if [ ! -f "$LOG_FILE" ] || [ ! -s "$LOG_FILE" ]; then
        echo -e "${YELLOW}Log dosyası bulunamadı veya boş.${NC}"
    else
        echo -e "${BLUE}Son 50 satır:${NC}"
        echo ""
        tail -n 50 "$LOG_FILE"
    fi
    
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# Disk bilgileri
show_disk_info() {
    clear
    echo -e "${BLUE}${BOLD}  DİSK BİLGİLERİ${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    df -h
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# CPU bilgileri
show_cpu_info() {
    clear
    echo -e "${BLUE}${BOLD}  CPU BİLGİLERİ${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${BLUE}İşlemci Modeli:${NC}"
    grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^[ \t]*//'
    echo ""
    echo -e "${BLUE}Toplam Çekirdek Sayısı:${NC} $(grep -c processor /proc/cpuinfo)"
    echo ""
    echo -e "${BLUE}Detaylı Bilgi:${NC}"
    cat /proc/cpuinfo | head -20
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# RAM bilgileri
show_ram_info() {
    clear
    echo -e "${BLUE}${BOLD}  RAM BİLGİLERİ${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${BLUE}Bellek Kullanımı:${NC}"
    free -h
    echo ""
    echo -e "${BLUE}Detaylı Bilgi:${NC}"
    cat /proc/meminfo | head -20
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# Sistem kaynak tüketimi
show_resource_usage() {
    clear
    echo -e "${BLUE}${BOLD}  ANLIK KAYNAK TÜKETİMİ${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${YELLOW}Çıkmak için 'q' tuşuna basın${NC}"
    echo ""
    top
}

# Boyut bazlı temizleme
clean_by_size() {
    clear
    echo -e "${CYAN}${BOLD}  BOYUT BAZLI DOSYA TEMİZLEME${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${BLUE}Örnek: 100M (100MB), 1G (1GB), 500M (500MB)${NC}"
    echo -e "${YELLOW}Minimum dosya boyutu giriniz (örn: 100M):${NC} "
    read -r size_input
    
    if [ -z "$size_input" ]; then
        echo -e "${RED}Boyut girilmedi!${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${BLUE}Taranıyor...${NC}"
    local count=$(find /home/* -type f -size +"$size_input" 2>/dev/null | wc -l)
    
    if [ $count -eq 0 ]; then
        echo -e "${GREEN}✓ Belirtilen boyuttan büyük dosya bulunamadı.${NC}"
        read -p "Devam etmek için Enter'a basın..."
        return
    fi
    
    echo -e "${YELLOW}Bulunan dosya sayısı: ${BOLD}$count${NC}"
    echo ""
    echo -e "${RED}${BOLD}UYARI: Bu işlem geri alınamaz!${NC}"
    echo -e "${YELLOW}Bu işlemi onaylıyor musunuz? (e/h):${NC} "
    read -r confirmation
    
    if [[ ! "$confirmation" =~ ^[Ee]$ ]]; then
        echo -e "${YELLOW}İşlem iptal edildi.${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${BLUE}Temizleniyor...${NC}"
    local deleted_count=0
    local total_size=0
    
    log_message "=== Boyut bazlı temizleme başlatıldı - Minimum boyut: $size_input ==="
    
    OLDIFS="$IFS"
    IFS=$'\n'
    for file in $(find /home/* -type f -size +"$size_input" 2>/dev/null); do
        IFS="$OLDIFS"
        if [ -f "$file" ]; then
            local file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
            if rm -f "$file" 2>/dev/null; then
                deleted_count=$((deleted_count + 1))
                total_size=$((total_size + file_size))
                log_message "SİLİNDİ: $file (Boyut: $(numfmt --to=iec-i --suffix=B $file_size 2>/dev/null || echo "$file_size bytes"))"
                if [ $((deleted_count % 10)) -eq 0 ]; then
                    echo -ne "\r${GREEN}İşlenen dosya: $deleted_count${NC}"
                fi
            fi
        fi
    done
    IFS="$OLDIFS"
    
    echo ""
    echo ""
    echo -e "${GREEN}${BOLD}  ✓ İşlem Tamamlandı!${NC}"
    echo -e "${GREEN}  ────────────────────────────────────────────────────────────${NC}"
    echo -e "${GREEN}Silinen dosya sayısı:${NC} ${BOLD}$deleted_count${NC}"
    echo -e "${GREEN}Toplam kazanılan alan:${NC} ${BOLD}$(numfmt --to=iec-i --suffix=B $total_size 2>/dev/null || echo "$total_size bytes")${NC}"
    log_message "=== Boyut bazlı temizleme tamamlandı - Silinen: $deleted_count, Toplam alan: $total_size ==="
    read -p "Devam etmek için Enter'a basın..."
}

# Tarih bazlı temizleme
clean_by_date() {
    clear
    echo -e "${CYAN}${BOLD}  TARİH BAZLI DOSYA TEMİZLEME${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${BLUE}Örnek: 30 (30 günden eski), 90 (90 günden eski)${NC}"
    echo -e "${YELLOW}Kaç günden eski dosyalar temizlensin? (örn: 30):${NC} "
    read -r days_input
    
    if ! [[ "$days_input" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Geçersiz gün sayısı!${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${BLUE}Taranıyor...${NC}"
    local count=$(find /home/* -type f -mtime +"$days_input" 2>/dev/null | wc -l)
    
    if [ $count -eq 0 ]; then
        echo -e "${GREEN}✓ Belirtilen tarihten eski dosya bulunamadı.${NC}"
        read -p "Devam etmek için Enter'a basın..."
        return
    fi
    
    echo -e "${YELLOW}Bulunan dosya sayısı: ${BOLD}$count${NC}"
    echo ""
    echo -e "${RED}${BOLD}UYARI: Bu işlem geri alınamaz!${NC}"
    echo -e "${YELLOW}Bu işlemi onaylıyor musunuz? (e/h):${NC} "
    read -r confirmation
    
    if [[ ! "$confirmation" =~ ^[Ee]$ ]]; then
        echo -e "${YELLOW}İşlem iptal edildi.${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${BLUE}Temizleniyor...${NC}"
    local deleted_count=0
    
    log_message "=== Tarih bazlı temizleme başlatıldı - $days_input günden eski dosyalar ==="
    
    OLDIFS="$IFS"
    IFS=$'\n'
    for file in $(find /home/* -type f -mtime +"$days_input" 2>/dev/null); do
        IFS="$OLDIFS"
        if [ -f "$file" ]; then
            if rm -f "$file" 2>/dev/null; then
                deleted_count=$((deleted_count + 1))
                log_message "SİLİNDİ: $file"
                if [ $((deleted_count % 10)) -eq 0 ]; then
                    echo -ne "\r${GREEN}İşlenen dosya: $deleted_count${NC}"
                fi
            fi
        fi
    done
    IFS="$OLDIFS"
    
    echo ""
    echo ""
    echo -e "${GREEN}${BOLD}✓ İşlem Tamamlandı!${NC}"
    echo -e "${GREEN}Silinen dosya sayısı:${NC} ${BOLD}$deleted_count${NC}"
    log_message "=== Tarih bazlı temizleme tamamlandı - Silinen: $deleted_count ==="
    read -p "Devam etmek için Enter'a basın..."
}

# En çok yer kaplayan dosyaları bul
find_largest_files() {
    clear
    echo -e "${CYAN}${BOLD}  EN ÇOK YER KAPLAYAN DOSYALAR${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${YELLOW}Kaç dosya gösterilsin? (örn: 20):${NC} "
    read -r limit_input
    
    if ! [[ "$limit_input" =~ ^[0-9]+$ ]]; then
        limit_input=20
    fi
    
    echo ""
    echo -e "${BLUE}En büyük $limit_input dosya aranıyor...${NC}"
    echo ""
    
    find /home/* -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n "$limit_input" | nl
    
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# Boş dizinleri temizle
clean_empty_dirs() {
    clear
    echo -e "${CYAN}${BOLD}  BOŞ DİZİNLERİ TEMİZLEME${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    
    echo -e "${BLUE}Taranıyor...${NC}"
    local count=$(find /home/* -type d -empty 2>/dev/null | wc -l)
    
    if [ $count -eq 0 ]; then
        echo -e "${GREEN}✓ Boş dizin bulunamadı.${NC}"
        read -p "Devam etmek için Enter'a basın..."
        return
    fi
    
    echo -e "${YELLOW}Bulunan boş dizin sayısı: ${BOLD}$count${NC}"
    echo ""
    echo -e "${RED}${BOLD}UYARI: Bu işlem geri alınamaz!${NC}"
    echo -e "${YELLOW}Bu işlemi onaylıyor musunuz? (e/h):${NC} "
    read -r confirmation
    
    if [[ ! "$confirmation" =~ ^[Ee]$ ]]; then
        echo -e "${YELLOW}İşlem iptal edildi.${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${BLUE}Temizleniyor...${NC}"
    local deleted_count=0
    
    log_message "=== Boş dizin temizleme başlatıldı ==="
    
    OLDIFS="$IFS"
    IFS=$'\n'
    for dir in $(find /home/* -type d -empty 2>/dev/null); do
        IFS="$OLDIFS"
        if [ -d "$dir" ] && [ -z "$(ls -A "$dir" 2>/dev/null)" ]; then
            if rmdir "$dir" 2>/dev/null; then
                deleted_count=$((deleted_count + 1))
                log_message "SİLİNDİ (Dizin): $dir"
            fi
        fi
    done
    IFS="$OLDIFS"
    
    echo ""
    echo -e "${GREEN}${BOLD}✓ İşlem Tamamlandı!${NC}"
    echo -e "${GREEN}Silinen boş dizin sayısı:${NC} ${BOLD}$deleted_count${NC}"
    log_message "=== Boş dizin temizleme tamamlandı - Silinen: $deleted_count ==="
    read -p "Devam etmek için Enter'a basın..."
}

# Dry-run modu
dry_run_mode() {
    clear
    echo -e "${CYAN}${BOLD}  DRY-RUN MODU (SADECE GÖSTER)${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${GREEN}Bu modda dosyalar silinmez, sadece gösterilir.${NC}"
    echo ""
    echo -e "${YELLOW}Hangi kategoriyi kontrol etmek istersiniz?${NC}"
    echo -e "${GREEN}  (1)${NC} Yedek Dosyaları"
    echo -e "${GREEN}  (2)${NC} Log Dosyaları"
    echo -e "${GREEN}  (3)${NC} Sıkıştırılmış Dosyalar"
    echo -e "${GREEN}  (4)${NC} Medya Dosyaları"
    echo -e "${GREEN}  (5)${NC} Program Dosyaları"
    echo -e "${GREEN}  (10)${NC} Tümü"
    echo ""
    echo -e "${CYAN}Seçiminiz:${NC} "
    read -r dry_choice
    
    local patterns=""
    local description=""
    
    case $dry_choice in
        1) patterns="backup-*.tar.gz"; description="Yedek Dosyaları" ;;
        2) patterns="*.gz"; description="Log Dosyaları" ;;
        3) patterns="*.tar.gz *.gz *.zip *.rar"; description="Sıkıştırılmış Dosyalar" ;;
        4) patterns="*.mp3 *.mp4 *.flv *.avi *.wmv *.dat *.swf"; description="Medya Dosyaları" ;;
        5) patterns="*.exe *.bat *.psd *.cdr"; description="Program Dosyaları" ;;
        10) patterns="backup-*.tar.gz *.gz *.tar.gz *.zip *.rar *.mp3 *.mp4 *.flv *.avi *.wmv *.dat *.exe *.bat *.psd *.cdr *.swf *.wpress"; description="Tüm Gereksiz Dosyalar" ;;
        *)
            echo -e "${RED}Geçersiz seçim!${NC}"
            sleep 2
            return
            ;;
    esac
    
    echo ""
    echo -e "${BLUE}$description taranıyor...${NC}"
    echo ""
    
    local total_size=0
    local file_count=0
    local pattern_array=($patterns)
    
    for pattern in "${pattern_array[@]}"; do
        OLDIFS="$IFS"
        IFS=$'\n'
        for file in $(find /home/* -name "$pattern" -type f 2>/dev/null | head -100); do
            IFS="$OLDIFS"
            if [ -f "$file" ]; then
                file_count=$((file_count + 1))
                local file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
                total_size=$((total_size + file_size))
                echo -e "${YELLOW}[$file_count]${NC} $file ${CYAN}($(numfmt --to=iec-i --suffix=B $file_size 2>/dev/null || echo "$file_size bytes"))${NC}"
            fi
        done
        IFS="$OLDIFS"
    done
    
    echo ""
    echo -e "${GREEN}  ────────────────────────────────────────────────────────────${NC}"
    echo -e "${GREEN}Toplam dosya sayısı:${NC} ${BOLD}$file_count${NC}"
    echo -e "${GREEN}Toplam boyut:${NC} ${BOLD}$(numfmt --to=iec-i --suffix=B $total_size 2>/dev/null || echo "$total_size bytes")${NC}"
    echo -e "${CYAN}Not:${NC} Bu modda dosyalar silinmedi, sadece gösterildi."
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# Kullanıcı bazlı temizleme
clean_by_user() {
    clear
    echo -e "${CYAN}${BOLD}  KULLANICI BAZLI TEMİZLEME${NC}"
    echo -e "${CYAN}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${BLUE}Mevcut kullanıcılar:${NC}"
    ls -1 /home/ 2>/dev/null | head -20
    echo ""
    echo -e "${YELLOW}Kullanıcı adını giriniz (örn: user1):${NC} "
    read -r user_input
    
    if [ -z "$user_input" ] || [ ! -d "/home/$user_input" ]; then
        echo -e "${RED}Geçersiz kullanıcı adı!${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${YELLOW}Hangi dosya türlerini temizlemek istersiniz?${NC}"
    echo -e "${GREEN}  (1)${NC} Yedek Dosyaları"
    echo -e "${GREEN}  (2)${NC} Log Dosyaları"
    echo -e "${GREEN}  (3)${NC} Sıkıştırılmış Dosyalar"
    echo -e "${GREEN}  (4)${NC} Medya Dosyaları"
    echo -e "${GREEN}  (5)${NC} Program Dosyaları"
    echo -e "${GREEN}  (10)${NC} Tümü"
    echo ""
    echo -e "${CYAN}Seçiminiz:${NC} "
    read -r user_choice
    
    local patterns=""
    local description=""
    
    case $user_choice in
        1) patterns="backup-*.tar.gz"; description="Yedek Dosyaları" ;;
        2) patterns="*.gz"; description="Log Dosyaları" ;;
        3) patterns="*.tar.gz *.gz *.zip *.rar"; description="Sıkıştırılmış Dosyalar" ;;
        4) patterns="*.mp3 *.mp4 *.flv *.avi *.wmv *.dat *.swf"; description="Medya Dosyaları" ;;
        5) patterns="*.exe *.bat *.psd *.cdr"; description="Program Dosyaları" ;;
        10) patterns="backup-*.tar.gz *.gz *.tar.gz *.zip *.rar *.mp3 *.mp4 *.flv *.avi *.wmv *.dat *.exe *.bat *.psd *.cdr *.swf *.wpress"; description="Tüm Gereksiz Dosyalar" ;;
        *)
            echo -e "${RED}Geçersiz seçim!${NC}"
            sleep 2
            return
            ;;
    esac
    
    echo ""
    echo -e "${BLUE}/home/$user_input dizininde $description taranıyor...${NC}"
    
    local total_count=0
    local pattern_array=($patterns)
    
    for pattern in "${pattern_array[@]}"; do
        local count=$(find "/home/$user_input" -name "$pattern" -type f 2>/dev/null | wc -l)
        total_count=$((total_count + count))
    done
    
    if [ $total_count -eq 0 ]; then
        echo -e "${GREEN}✓ Temizlenecek dosya bulunamadı.${NC}"
        read -p "Devam etmek için Enter'a basın..."
        return
    fi
    
    echo -e "${YELLOW}Bulunan dosya sayısı: ${BOLD}$total_count${NC}"
    echo ""
    echo -e "${RED}${BOLD}UYARI: Bu işlem geri alınamaz!${NC}"
    echo -e "${YELLOW}Bu işlemi onaylıyor musunuz? (e/h):${NC} "
    read -r confirmation
    
    if [[ ! "$confirmation" =~ ^[Ee]$ ]]; then
        echo -e "${YELLOW}İşlem iptal edildi.${NC}"
        sleep 2
        return
    fi
    
    echo ""
    echo -e "${BLUE}Temizleniyor...${NC}"
    local deleted_count=0
    
    log_message "=== Kullanıcı bazlı temizleme başlatıldı - Kullanıcı: $user_input, Kategori: $description ==="
    
    for pattern in "${pattern_array[@]}"; do
        OLDIFS="$IFS"
        IFS=$'\n'
        for file in $(find "/home/$user_input" -name "$pattern" -type f 2>/dev/null); do
            IFS="$OLDIFS"
            if [ -f "$file" ]; then
                if rm -f "$file" 2>/dev/null; then
                    deleted_count=$((deleted_count + 1))
                    log_message "SİLİNDİ: $file"
                    if [ $((deleted_count % 10)) -eq 0 ]; then
                        echo -ne "\r${GREEN}İşlenen dosya: $deleted_count${NC}"
                    fi
                fi
            fi
        done
        IFS="$OLDIFS"
    done
    
    echo ""
    echo ""
    echo -e "${GREEN}${BOLD}✓ İşlem Tamamlandı!${NC}"
    echo -e "${GREEN}Silinen dosya sayısı:${NC} ${BOLD}$deleted_count${NC}"
    log_message "=== Kullanıcı bazlı temizleme tamamlandı - Silinen: $deleted_count ==="
    read -p "Devam etmek için Enter'a basın..."
}

# Disk kullanım analizi
disk_usage_analysis() {
    clear
    echo -e "${BLUE}${BOLD}  DİSK KULLANIM ANALİZİ${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    
    echo -e "${BLUE}Genel Disk Kullanımı:${NC}"
    df -h
    echo ""
    
    echo -e "${BLUE}Kullanıcı Bazlı Disk Kullanımı:${NC}"
    echo ""
    for user_dir in /home/*; do
        if [ -d "$user_dir" ]; then
            local user_name=$(basename "$user_dir")
            local usage=$(du -sh "$user_dir" 2>/dev/null | cut -f1)
            echo -e "${CYAN}$user_name:${NC} $usage"
        fi
    done
    
    echo ""
    echo -e "${BLUE}En Çok Yer Kaplayan 10 Dizin:${NC}"
    du -h /home/* 2>/dev/null | sort -rh | head -10 | nl
    
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# İstatistik raporu
generate_statistics() {
    clear
    echo -e "${BLUE}${BOLD}  İSTATİSTİK RAPORU OLUŞTURMA${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    
    local report_file="/root/temizlikci-rapor-$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "═══════════════════════════════════════════════════════════════"
        echo "  WEB SERVER TEMİZLEYİCİ - İSTATİSTİK RAPORU"
        echo "  Oluşturulma Tarihi: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "═══════════════════════════════════════════════════════════════"
        echo ""
        echo "DİSK KULLANIMI:"
        echo "───────────────────────────────────────────────────────────────"
        df -h
        echo ""
        echo "KULLANICI BAZLI KULLANIM:"
        echo "───────────────────────────────────────────────────────────────"
        for user_dir in /home/*; do
            if [ -d "$user_dir" ]; then
                echo "$(basename "$user_dir"): $(du -sh "$user_dir" 2>/dev/null | cut -f1)"
            fi
        done
        echo ""
        echo "DOSYA TÜRÜ BAZLI SAYILAR:"
        echo "───────────────────────────────────────────────────────────────"
        echo "Yedek Dosyaları (.tar.gz backup-*): $(find /home/* -name 'backup-*.tar.gz' -type f 2>/dev/null | wc -l)"
        echo "Log Dosyaları (.gz): $(find /home/* -name '*.gz' -type f 2>/dev/null | wc -l)"
        echo "Zip Dosyaları: $(find /home/* -name '*.zip' -type f 2>/dev/null | wc -l)"
        echo "Rar Dosyaları: $(find /home/* -name '*.rar' -type f 2>/dev/null | wc -l)"
        echo "MP3 Dosyaları: $(find /home/* -name '*.mp3' -type f 2>/dev/null | wc -l)"
        echo "MP4 Dosyaları: $(find /home/* -name '*.mp4' -type f 2>/dev/null | wc -l)"
        echo "EXE Dosyaları: $(find /home/* -name '*.exe' -type f 2>/dev/null | wc -l)"
        echo ""
        echo "EN BÜYÜK 20 DOSYA:"
        echo "───────────────────────────────────────────────────────────────"
        find /home/* -type f -exec du -h {} + 2>/dev/null | sort -rh | head -20
        echo ""
        echo "BOŞ DİZİN SAYISI:"
        echo "───────────────────────────────────────────────────────────────"
        echo "$(find /home/* -type d -empty 2>/dev/null | wc -l) boş dizin bulundu"
    } > "$report_file"
    
    echo -e "${GREEN}${BOLD}✓ Rapor oluşturuldu!${NC}"
    echo -e "${CYAN}Rapor dosyası:${NC} $report_file"
    echo ""
    cat "$report_file"
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# Kullanıcı bazlı disk kullanımı
user_disk_usage() {
    clear
    echo -e "${BLUE}${BOLD}  KULLANICI BAZLI DİSK KULLANIMI${NC}"
    echo -e "${BLUE}  ────────────────────────────────────────────────────────────${NC}"
    echo ""
    
    echo -e "${BLUE}Kullanıcı Dizin Boyutları:${NC}"
    echo ""
    printf "%-20s %15s %15s\n" "Kullanıcı" "Boyut" "Dosya Sayısı"
    echo "───────────────────────────────────────────────────────────────"
    
    for user_dir in /home/*; do
        if [ -d "$user_dir" ]; then
            local user_name=$(basename "$user_dir")
            local size=$(du -sh "$user_dir" 2>/dev/null | cut -f1)
            local file_count=$(find "$user_dir" -type f 2>/dev/null | wc -l)
            printf "%-20s %15s %15s\n" "$user_name" "$size" "$file_count"
        fi
    done | sort -k2 -hr
    
    echo ""
    read -p "Devam etmek için Enter'a basın..."
}

# Ana döngü
main() {
    while true; do
        show_banner
        show_menu
        echo -ne "${CYAN}${BOLD}Seçiminiz: ${NC}"
        read -r secenek
        
        case $secenek in
            0)
                update_script
                ;;
            1)
                clean_files "backup" "backup-*.tar.gz" "YEDEK DOSYALARI TEMİZLEME"
                ;;
            2)
                clean_files "logs" "*.gz" "LOG DOSYALARI TEMİZLEME"
                ;;
            3)
                clean_files "archive" "*.tar.gz *.gz *.zip *.rar" "SIKIŞTIRILMIŞ DOSYALAR TEMİZLEME"
                ;;
            4)
                clean_files "media" "*.mp3 *.mp4 *.flv *.avi *.wmv *.dat *.swf" "SES VE VİDEO DOSYALARI TEMİZLEME"
                ;;
            5)
                clean_files "programs" "*.exe *.bat *.psd *.cdr" "PROGRAM DOSYALARI TEMİZLEME"
                ;;
            6)
                clean_by_size
                ;;
            7)
                clean_by_date
                ;;
            10)
                clean_files "all" "backup-*.tar.gz *.gz *.tar.gz *.zip *.rar *.mp3 *.mp4 *.flv *.avi *.wmv *.dat *.exe *.bat *.psd *.cdr *.swf *.wpress" "TÜM GEREKSİZ DOSYALARI TEMİZLEME"
                ;;
            11)
                setup_cron
                ;;
            12)
                view_logs
                ;;
            13)
                find_largest_files
                ;;
            14)
                clean_empty_dirs
                ;;
            15)
                dry_run_mode
                ;;
            16)
                clean_by_user
                ;;
            20)
                show_disk_info
                ;;
            21)
                show_cpu_info
                ;;
            22)
                show_ram_info
                ;;
            23)
                show_resource_usage
                ;;
            24)
                disk_usage_analysis
                ;;
            25)
                generate_statistics
                ;;
            26)
                user_disk_usage
                ;;
            99)
                clear
                echo -e "${GREEN}${BOLD}Çıkılıyor...${NC}"
                echo -e "${CYAN}İyi günler!${NC}"
                exit 0
                ;;
            *)
                echo ""
                echo -e "${RED}${BOLD}✗ Hatalı bir numara girdiniz!${NC}"
                sleep 2
                ;;
        esac
    done
}

# Script başlatılıyor
main
