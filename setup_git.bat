@echo off
chcp 65001 > nul
echo 🔧 إعداد Git للعمل مع StrucTech Repository
echo ==========================================

echo.
echo 📋 إعدادات Git الحالية:
echo الاسم: 
git config --global user.name
echo الإيميل: 
git config --global user.email
echo.

echo 🔧 خيارات الحل:
echo 1. استخدام Personal Access Token (الأفضل)
echo 2. إضافة SSH Key
echo 3. إضافة Ahmed-Shatla كـ Collaborator
echo.

set /p CHOICE="اختر الحل (1-3): "

if "%CHOICE%"=="1" goto TOKEN
if "%CHOICE%"=="2" goto SSH
if "%CHOICE%"=="3" goto COLLABORATOR
goto INVALID

:TOKEN
echo.
echo 🔑 إعداد Personal Access Token:
echo ===============================
echo.
echo خطوات إنشاء Token:
echo 1. اذهب إلى: https://github.com/settings/tokens
echo 2. اضغط "Generate new token (classic)"
echo 3. أعط الـ token اسم: "Sama Inventory System"
echo 4. اختر Expiration: "No expiration" أو "1 year"
echo 5. اختر Scopes: "repo" (Full control of private repositories)
echo 6. اضغط "Generate token"
echo 7. انسخ الـ token (سيظهر مرة واحدة فقط!)
echo.

pause

echo.
set /p TOKEN="الصق الـ Personal Access Token هنا: "

if "%TOKEN%"=="" (
    echo ❌ لم تدخل token!
    pause
    exit /b 1
)

echo.
echo 🔧 إعداد الـ remote مع token...

:: إزالة الـ remote الحالي
git remote remove origin

:: إضافة remote جديد مع token
git remote add origin https://%TOKEN%@github.com/StrucTech/Sama-Inventory-System.git

echo ✅ تم إعداد الـ token بنجاح!
goto TEST

:SSH
echo.
echo 🔐 إعداد SSH Key:
echo ================
echo.
echo إذا لم يكن لديك SSH key:
echo 1. ssh-keygen -t ed25519 -C "a.m.abdelaziz141@gmail.com"
echo 2. اضغط Enter عدة مرات
echo 3. cat ~/.ssh/id_ed25519.pub
echo 4. انسخ المحتوى واذهب إلى: https://github.com/settings/keys
echo 5. اضغط "New SSH key" وألصق المحتوى
echo.

echo إذا كان لديك SSH key بالفعل:
git remote remove origin
git remote add origin git@github.com:StrucTech/Sama-Inventory-System.git

echo ✅ تم إعداد SSH!
goto TEST

:COLLABORATOR
echo.
echo 👥 إضافة Collaborator:
echo ====================
echo.
echo يجب على مالك الـ Repository (StrucTech) القيام بالتالي:
echo.
echo 1. الذهاب إلى: https://github.com/StrucTech/Sama-Inventory-System/settings/access
echo 2. اضغط "Add collaborator"
echo 3. أدخل: Ahmed-Shatla
echo 4. اختر صلاحية: "Write" أو "Admin"
echo 5. إرسال دعوة
echo.
echo بعد قبول الدعوة، ستتمكن من الـ push بشكل طبيعي.
echo.
pause
exit /b 0

:TEST
echo.
echo 🧪 اختبار الاتصال...
git ls-remote origin > nul 2>&1

if errorlevel 1 (
    echo ❌ فشل في الاتصال بالـ repository
    echo تأكد من:
    echo - صحة الـ token أو SSH key
    echo - وجود صلاحيات للـ repository
    pause
    exit /b 1
)

echo ✅ تم الاتصال بالـ repository بنجاح!
echo.

echo 🚀 محاولة push...
git push -u origin main

if errorlevel 1 (
    echo ❌ فشل في الـ push
    echo قد تحتاج لـ force push إذا كان هناك تضارب:
    echo git push -u origin main --force
) else (
    echo ✅ تم الـ push بنجاح!
    echo.
    echo 🎉 الآن يمكنك استخدام:
    echo - git push (للتحديثات العادية)
    echo - create_release.bat (لإنشاء إصدارات جديدة)
)

echo.
pause
exit /b 0

:INVALID
echo ❌ خيار غير صحيح!
pause
exit /b 1