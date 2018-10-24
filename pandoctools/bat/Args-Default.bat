@echo off
:: May use variables predefined in the profile:
::   %prof% (profile name)

:: May use variables predefined in pandoctools:
::   %set_resolve% (sets var to a resolved path to a file.
::                  Searches in %APPDATA%\pandoc\pandoctools
::                  then in <...>\site-packages\pandoctools\bat folders)
::   %in_ext% (input file extension like "md")
::   %in_ext_full% (extended input file extension like "py.md" -
::                  everything after first dot)
::   %out_ext% (output file extension like "md")
::   %out_ext_full% (extended output file extension like "r.ipynb")
::   %input_file% (input file path with extension)
::   %output_file% (output file path with extension)
::   %scripts% (conda environment Scripts folder)

::   %source% (call batch script from PATH but not CWD)
::   %r% (run program from PATH but not from CWD)
::   %import% (try call batch script from pandoctools folder
::             in user data. Then call from pandoctools module)
::   %pyprepPATH% (prepend PATH with python environment)
::   %setUTF8% (set chcp and PYTHONIOENCODING to UTF-8)
::   %root_env%
::   %env_path%

:: Exports vars:
::   %from%
::   %to%
::   %t% (argument for filters)
::   %reader_args%
::   %writer_args%
::   %stdin_plus%
::   %metas% (additional metadata files)

:: May be useful:
::   %source% setvar v echo hello


set "out_ext_full=.%out_ext_full%"
set "reader_args= "
set "writer_args= "
set "t="

:: Do not work inside if-else:
%set_resolve% _meta_prof "Meta-%prof%.yaml"
%set_resolve% _meta_ipynb_R "Meta-ipynb-R.yaml"
%set_resolve% _meta_ipynb "Meta-ipynb-py3.yaml"
%set_resolve% _templ_docx "Template-%prof%.docx"


if "%in_ext%"=="" (
    set from=markdown

) else if "%in_ext%"=="md" (
    set from=markdown

) else if "%in_ext%"=="py" (
    set from=markdown

) else (
    set "from=%in_ext%"
)


set "_jupymd=markdown-bracketed_spans-fenced_divs-link_attributes-simple_tables-multiline_tables-grid_tables-pipe_tables-fenced_code_attributes-markdown_in_html_blocks-table_captions-smart"
set metas="%_meta_prof%"
set "to=%out_ext%"

if "%out_ext%"=="" (
    set to=markdown

) else if "%out_ext%"=="md" (
    set to=markdown

) else if "%out_ext_full:~-8%"==".r.ipynb" (
    set "to=%_jupymd%"
    set t=markdown
    set metas=%metas% "%_meta_ipynb_R%"

) else if "%out_ext%"=="ipynb" (
    set "to=%_jupymd%"
    set t=markdown
    set metas=%metas% "%_meta_ipynb%"

) else if "%out_ext%"=="docx" (
    set writer_args=--reference-doc="%_templ_docx%" -o "%output_file%" %writer_args%
)

if "%t%" == "" set "t=%to%"
