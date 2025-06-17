#!/bin/bash

# Lấy đường dẫn của script đang chạy
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Các biến cấu hình
VM="view_model"
COMPONENT="components"
PARENT_DIR="${SCRIPT_DIR}/template_new_page"
REPLACE_SNAKE="_replace_snake_came"
REPLACE_PASCAL="ReplacePascalCame"
EX="dart"

# Hàm chuyển từ PascalCase sang snake_case
convert_pascal_to_snake_case() {
    nameSnake=$(echo "$1" | sed -r 's/([A-Z])/_\L\1/g' | sed 's/^_//')
    namePascal="$1"
}

# Hàm chuyển từ snake_case sang PascalCase
convert_snake_to_pascal_case() {
    nameSnake="$1"
    namePascal=$(echo "$1" | sed -r 's/(^|_)([a-z])/\U\2/g')
}

# Hàm thay đổi nội dung trong file
change_content_file() {
    if [ -f "$3" ]; then
        sed -i "s/$1/$2/g" "$3"
    else
        echo "File $3 không tồn tại."
    fi
}

# Hàm đổi tên file
rename_file() {
    if [ -f "$1" ]; then
        mv "$1" "$2"
    else
        echo "File $1 không tồn tại."
    fi
}

# Hàm tạo trang mới
create_new_page() {
    {
        # Đường dẫn file cũ và mới
        pageNameOld="${newDir}/${REPLACE_SNAKE}_page.${EX}"
        pageNameNew="${newDir}/${nameSnake}_page.${EX}"

        pageViewModelOld="${newDir}/${VM}/${REPLACE_SNAKE}_view_model.${EX}"
        pageViewModelNew="${newDir}/${VM}/${nameSnake}_view_model.${EX}"

        pageStateOld="${newDir}/${VM}/${REPLACE_SNAKE}_state.${EX}"
        pageStateNew="${newDir}/${VM}/${nameSnake}_state.${EX}"

        exampleComponentNew="${newDir}/${COMPONENT}/counter.${EX}"

        # Copy template
        echo "Copying template từ $PARENT_DIR đến $newDir..."
        cp -r "$PARENT_DIR" "$newDir"

        # Main page
        rename_file "$pageNameOld" "$pageNameNew"
        change_content_file "$REPLACE_PASCAL" "$namePascal" "$pageNameNew"
        change_content_file "$REPLACE_SNAKE" "$nameSnake" "$pageNameNew"

        # ViewModel
        rename_file "$pageViewModelOld" "$pageViewModelNew"
        change_content_file "$REPLACE_PASCAL" "$namePascal" "$pageViewModelNew"
        change_content_file "$REPLACE_SNAKE" "$nameSnake" "$pageViewModelNew"

        # State
        rename_file "$pageStateOld" "$pageStateNew"
        change_content_file "$REPLACE_PASCAL" "$namePascal" "$pageStateNew"
        change_content_file "$REPLACE_SNAKE" "$nameSnake" "$pageStateNew"

        # Example component
        change_content_file "$REPLACE_PASCAL" "$namePascal" "$exampleComponentNew"
        change_content_file "$REPLACE_SNAKE" "$nameSnake" "$exampleComponentNew"

    } || {
        # Xóa thư mục nếu có lỗi
        rm -rf "$newDir"
        echo "Đã xảy ra lỗi. Tạo trang $nameSnake thất bại."
    }
}

# Thư mục gốc
dir="lib/presentation/features"
nameSnake=""
namePascal=""

# Chuyển đổi tên từ tham số đầu vào
convert_snake_to_pascal_case "$1"
newDir="${dir}/${nameSnake}"

# Kiểm tra nếu thư mục đã tồn tại
if [ ! -d "$newDir" ]; then
    echo "Đang tạo trang $nameSnake..."
    create_new_page
else
    echo "Thư mục $newDir đã tồn tại. Tạo trang $nameSnake thất bại."
fi
