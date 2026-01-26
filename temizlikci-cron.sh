#!/bin/bash

# Log dosyası yolu
LOG_FILE="/root/temizlikci.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Log fonksiyonu
log_message() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# Temizleme fonksiyonu
clean_files() {
    local pattern="$1"
    local description="$2"
    local count=0
    
    while IFS= read -r file; do
        if [ -f "$file" ] && rm -f "$file" 2>/dev/null; then
            count=$((count + 1))
            log_message "SİLİNDİ: $file"
        fi
    done < <(find /home/* -name "$pattern" -type f 2>/dev/null)
    
    if [ $count -gt 0 ]; then
        log_message "$description: $count dosya silindi"
    fi
    
    return $count
}

# Ana temizleme işlemi
log_message "=== Otomatik temizleme başlatıldı ==="

total_deleted=0

# Yedek dosyaları
clean_files "backup-*.tar.gz" "Yedek dosyalar"
total_deleted=$((total_deleted + $?))

# Log dosyaları
clean_files "*.gz" "Log dosyalar"
total_deleted=$((total_deleted + $?))

# Sıkıştırılmış dosyalar
clean_files "*.tar.gz" "Tar.gz dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.zip" "Zip dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.rar" "Rar dosyalar"
total_deleted=$((total_deleted + $?))

# Medya dosyaları
clean_files "*.mp3" "MP3 dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.mp4" "MP4 dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.flv" "FLV dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.avi" "AVI dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.wmv" "WMV dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.dat" "DAT dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.swf" "SWF dosyalar"
total_deleted=$((total_deleted + $?))

# Program dosyaları
clean_files "*.exe" "EXE dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.bat" "BAT dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.psd" "PSD dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.cdr" "CDR dosyalar"
total_deleted=$((total_deleted + $?))
clean_files "*.wpress" "WPRESS dosyalar"
total_deleted=$((total_deleted + $?))

log_message "=== Otomatik temizleme tamamlandı - Toplam silinen: $total_deleted dosya ==="
