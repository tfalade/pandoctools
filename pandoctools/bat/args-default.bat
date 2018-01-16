@echo off

if        "%in_ext%"=="" (
    set from=markdown

) else if "%in_ext%"=="md" (
    set from=markdown

) else (
    set from=%in_ext%
)


if        "%out_ext%"=="" (
    set to=markdown

) else if "%out_ext%"=="md" (
    set to=markdown

) else (
    set to=%out_ext%
)


set reader_args=-f "%from%"
set writer_args=-t "%to%" --standalone --self-contained
set inputs=stdin
:: stdin from previous operations + meta-default.yaml:
set all_inputs=stdin "%config%\meta-default.yaml"
