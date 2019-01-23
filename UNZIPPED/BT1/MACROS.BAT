@echo off
if %config%==ndos goto ndos_end

:macros
doskey btmacros=echo off $tdoskey /macros $techo on
doskey bip=echo off $tbt bip 200 2000 $techo on
doskey data=echo off $tbt data 7 por esf $techo on
doskey fade=echo off $tbt fade 1 1 7 100 $1 $2 $techo on
doskey scroll_esq=echo off $tbt scroll 1 81 7 100 $1 esq $techo on
doskey scroll_dir=echo off $tbt scroll 1 0 7 100 $1 dir $techo on
doskey horas=echo off $tbt relogio 7 cent $techo on
doskey typeit=echo off $tbt typeit 7 15 0 50 50 $1 $2 $techo on
doskey macros=echo off $tdoskey /macros $techo on
echo Macros Doskey carregados
echo Para ajuda tecle BTMACROS no prompt do DOS
echo Limpe todas as macros com Alt-F10
echo.
goto end

:ndos_end
echo Para usar s¢ com o Command.Com n„o com NDos.com
:end
