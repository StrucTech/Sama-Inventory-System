@echo off
chcp 65001 > nul
echo 🔑 إعداد Personal Access Token لـ GitHub
echo =====================================

echo.
echo 📋 خطوات إنشاء Personal Access Token:
echo.
echo 1. اذهب إلى: https://github.com/settings/tokens
echo 2. اضغط "Generate new token (classic)"
echo 3. اكتب في Token name: "Sama Inventory System"
echo 4. اختر Expiration: "No expiration" (أو حسب تفضيلك)
echo 5. في Select scopes، اختر: "repo" ✅ (Full control of private repositories)
echo 6. اضغط "Generate token" (أخضر في الأسفل)
echo 7. انسخ الـ token الذي سيظهر (سيظهر مرة واحدة فقط!)
echo.

echo 🌐 فتح صفحة GitHub Tokens...
start https://github.com/settings/tokens

echo.
echo انتظر حتى تنشئ الـ token ثم ارجع هنا...
pause

echo.
set /p TOKEN="الصق الـ Personal Access Token هنا: "

if "%TOKEN%"=="" (
    echo ❌ لم تدخل token!
    pause
    exit /b 1
)

echo.
echo 🔧 إعداد Git مع الـ token...

:: إضافة الـ remote مع الـ token
git remote add origin https://%TOKEN%@github.com/StrucTech/Sama-Inventory-System.git

echo.
echo 🧪 اختبار الاتصال...
git ls-remote origin >nul 2>&1

if errorlevel 1 (
    echo ❌ فشل في الاتصال!
    echo تأكد من:
    echo - صحة الـ token
    echo - اختيار صلاحية "repo" عند إنشاء الـ token
    pause
    exit /b 1
)

echo ✅ تم الاتصال بنجاح!

echo.
echo 🚀 محاولة push للكود...
git push -u origin main

if errorlevel 1 (
    echo.
    echo ⚠️ قد يكون هناك تضارب في التاريخ. جرب:
    echo git push -u origin main --force
    echo.
    set /p FORCE="هل تريد عمل force push؟ (y/n): "
    if /i "!FORCE!"=="y" (
        git push -u origin main --force
        if errorlevel 1 (
            echo ❌ فشل في الـ force push أيضاً
        ) else (
            echo ✅ تم الـ push بنجاح!
        )
    )
) else (
    echo ✅ تم الـ push بنجاح!
    echo.
    echo 🎉 الآن يمكنك:
    echo - استخدام git push للتحديثات العادية
    echo - تشغيل create_release.bat لإنشاء إصدارات جديدة
    echo - تشغيل build.bat لبناء النسخة المستقلة محلياً
)

echo.
echo 🔗 روابط مفيدة:
echo Repository: https://github.com/StrucTech/Sama-Inventory-System
echo Actions: https://github.com/StrucTech/Sama-Inventory-System/actions
echo Releases: https://github.com/StrucTech/Sama-Inventory-System/releases

pause