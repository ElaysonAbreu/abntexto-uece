%! abntexto-uece.cls
%! Public Domain Software 2025
%! 2025-08-27
%! 1.0
%! Elayson Abreu
%! abntexto.classe@gmail.com

% \codesection{Identificação da classe}

% \begin{code}
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{abntexto-uece}%
    [2025-08-23 1.0 Preparation of works in UECE standards]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{abntexto}}

\ProcessOptions

\LoadClass{abntexto}
%. \end{code}

% \codesection{Macros auxiliares}

% O comando `\RecortarEsquerda` remove espaço à esquerda a nível de processador de expansão, significando dizer que podemos fazer algo do tipo:
%\begin{xp}
%   \edef\y{ 123}
%   \edef\x{\RecortarEsquerda \y}
%   \show\x % >123.
%\end{xp}
% `\RecortarDireita` é análogo ao comando anterior e permite remover espaços à direita:
%\begin{xp}
%   \edef\y{123 }
%   \edef\x{\expandafter\RecortarDireita\expandafter{\y}}
%   \show\x % >123.
%\end{xp}
% `\RecortarAmbos` remove espaços à esquerda e direita.

% \begin{code}
\def\RecortarEsquerda{\romannumeral-`\.}

\count2=\catcode`?
\catcode`?=3
\def\RecortarDireita#1{\RecortarDireitaA#1? ?}
\def\RecortarDireitaA#1 ?{\RecortarDireitaB#1?}
\def\RecortarDireitaB#1?#2{#1}
\catcode`?=\count2

\def\RecortarAmbos#1{\expandafter\RecortarDireita\expandafter{\romannumeral-`\.#1}}
%. \end{code}

% \codesection{Macros de identificação do documento}

% Definindo macros de identificação do documento.

% \begin{code}
\def\Autor{\def\xAutor}
\def\Universidade{\def\xUniversidade}
\def\Centro{\def\xFaculdade{}\def\xPrograma{}\def\xCentro}
\def\Faculdade{\def\xCentro{}\def\xPrograma{}\def\xFaculdade}
\def\Programa{\def\xCentro{}\def\xFaculdade{}\def\xPrograma}
\def\Curso{\def\xEspecializacao{}\def\xCurso}
\def\Especializacao{\def\xCurso{}\def\xEspecializacao}
\def\SiglaDaInstituicao{\def\xSiglaDaInstituicao}
\def\Titulo{\def\xTitulo}
\def\Subtitulo{\def\xSubtitulo}
\def\Cidade{\def\xCidade}
\def\AnoDeEntrega{\def\xAnoDeEntrega}
\def\TipoDeTrabalho{\def\xTipoDeTrabalho}
\def\DescricaoDoTrabalho{\def\xDescricaoDoTrabalho}
\def\AreaDeConcentracao{\def\xAreaDeConcentracao}
\def\Orientador{\def\xOrientador}
\def\Coorientador{\def\xCoorientador}
\def\AvaliadorA{\def\xAvaliadorA}
\def\AvaliadorB{\def\xAvaliadorB}
\def\AvaliadorC{\def\xAvaliadorC}
\def\AvaliadorD{\def\xAvaliadorD}
\def\Agradecimentos{\def\xAgradecimentos}
\def\Dedicatoria{\def\xDedicatoria}
\def\Epigrafe{\def\xEpigrafe}
%. \end{code}

% `\xResumo` e `\xPalavrasChave` são definidos apenas como indicativo de que `\Resumo` e `\PalavrasChave` foram chamados pelo estudante e, adicionalmente, aqueles serão usados em `\CamposMandatorios`.

% `\Mandatorio\<atributo>` verifica se `\x<atributo>` está vazio ou indefinido. Se sim, uma mensagem de alerta é emitida pedindo que `\<atributo>{<valor>}` seja chamado no preâmbulo. `\CamposMandatorios` será chamado em `\begin{document}`.

% `\Centralizar` e `\Direita` serão úteis para alinhamento de caixas ou parágrafos de linhas únicas, por exemplo, `\Centralizar\begin{minipage}{<largura>}\end{minipage}`.

% \begin{code}
\def\Resumo#1#2{\def\xResumo{#2}\csdef{resumo/#1}{#2}}
\def\PalavrasChave#1#2{\def\xPalavrasChave{#2}\csdef{pchave/#1}{#2}%
    \def\tmp{#1}\@tempcnta=1 \doPalavrasChave#2,\relax,%
}
\def\doPalavrasChave#1,{\if&\RecortarEsquerda#1&\expandafter\doPalavrasChave \else
    \ifx\relax#1\else
        \csedef{xPalavraChave\@Alph\@tempcnta/\tmp}{\RecortarAmbos{#1}}%
        \advance\@tempcnta by1
        \expandafter\expandafter\expandafter \doPalavrasChave
    \fi\fi
}

\def\Mandatorio#1{\ifcsname x\expandafter\@gobble\string#1\endcsname
        \expandafter\ifx\csname x\expandafter\@gobble\string#1\endcsname\empty
        \ClassWarning{abntexto-uece}{Campo obrigatório vazio! "\string#1"}
        \csdef{x\expandafter\@gobble\string#1}{??}\fi
    \else
        \ClassWarning{abntexto-uece}{Campo obrigatório vazio! "\string#1"}
        \csdef{x\expandafter\@gobble\string#1}{??}
    \fi
}
\def\CamposMandatorios{
    \Mandatorio\Autor
    \Mandatorio\Universidade
    \Mandatorio\SiglaDaInstituicao
    \ifdefined\xCentro    \else
    \ifdefined\xFaculdade \else
    \ifdefined\xPrograma  \else
        \ClassWarning{abntexto-uece}{^^JUm dos três campos precisa ser chamado:
            \noexpand\Centro ou \noexpand\Faculdade ou \string\Programa!}
        \Centro{}\Faculdade{}\Programa{}%
    \fi\fi\fi
        \ifdefined\xCurso          \else
        \ifdefined\xEspecializacao \else
            \ClassWarning{abntexto-uece}{^^JUm dos dois campos precisa ser chamado:
                \noexpand\Curso ou \string\Especializacao!}
            \Curso{}\Especializacao{}
        \fi\fi
    \Mandatorio\SiglaDaInstituicao
    \Mandatorio\Titulo
    \Mandatorio\Subtitulo
    \Mandatorio\Cidade
    \Mandatorio\AnoDeEntrega
    \Mandatorio\TipoDeTrabalho
    \Mandatorio\DescricaoDoTrabalho
    \Mandatorio\AreaDeConcentracao
    \Mandatorio\Orientador
    \Mandatorio\Coorientador
    \Mandatorio\AvaliadorA
    \Mandatorio\Resumo
    \Mandatorio\PalavrasChave
}

\AtBeginDocument{\CamposMandatorios}

\def\Centralizar{\noindent\hfil}
\def\Direita{\noindent\hfill}
%. \end{code}

% \codesection{Impressão dos elementos pré-textuais}

% Definições de `\ImprimirCapa`, `\ImprimirFolhaDeRosto`, `\ImprimirFichaCatalografica`, `\ImprimirErrata`, `\ImprimirFolhaDeAprovacao`, `\ImprimirAvaliadores`, `\ImprimirDedicatoria`, `\ImprimirAgradecimentos`, `\ImprimirResumo`, `\ImprimirPalavrasChave`, `\ImprimirPretextual`, `\Metadados`. Todas essas intruções podem ser redefinidas pelo usuário.

% \begin{code}
\def\ImprimirCapa{
    \Centralizar
    \begin{minipage}{.7\linewidth}
        \centering
        \includegraphics[height=4\baselineskip]{example-image}\\
        \MakeUppercase{\xUniversidade}\\
        \MakeUppercase{\xCentro\xFaculdade\xPrograma}\\
        \MakeUppercase{\xCurso\xEspecializacao}\\
    \end{minipage}
    \Enter[3]
    \Centralizar\MakeUppercase{\xAutor}
    \Enter[5]
    \Centralizar
    \begin{minipage}{.7\linewidth}
        \centering\MakeUppercase{\xTitulo}
    \end{minipage}
    \vfill
    \Centralizar\MakeUppercase{\xCidade} % A próxima linha em branco é necessária.

    \Centralizar\MakeUppercase{\xAnoDeEntrega}
}
\def\ImprimirFolhaDeRosto{
    \Centralizar\MakeUppercase{\xAutor}
    \Enter[9]
    \Centralizar
    \begin{minipage}{.7\linewidth}
        \centering\MakeUppercase{\xTitulo}
    \end{minipage}
    \Enter[2]
    \Direita
    \begin{minipage}{.5\linewidth}
        \singlesp\nohyph
        \xDescricaoDoTrabalho
        \Enter
        Área de concentração: \xAreaDeConcentracao.\\
        Orientador(a): \xOrientador.\\
        Coorientador(a): \xCoorientador.
    \end{minipage}
    \vfill
    \Centralizar\MakeUppercase{\xCidade} % A próxima linha em branco é necessária.

    \Centralizar\MakeUppercase{\xAnoDeEntrega}
}
%. \end{code}

% É provável que a biblioteca de sua instituição forneça a ficha catalográfica em formato |.pdf|. Nesse caso, `\ImprimirFichaCatalografica` servirá apenas de preenchimento.

% \begin{code}
\def\CDU{000}
\def\CDD{A000}
\def\NumeroDeFolhas{100}
\edef\icardHeight{\the\dimexpr\icardHeight+4\baselineskip}

\def\ImprimirFichaCatalografica{
    \leavevmode\vfill
    \Centralizar Dados Internacionais de Catalogação na Publicação (CIP)
    \Enter[.5]
    \Centralizar
    \begin{indexcard}
        \noindent \CDD\hskip\parindent \qquad \xAutor

        \setbox0=\hbox{\CDD\qquad}\leftskip=\wd0 % A linha em branco antes
                                                 % dessa instrução é necessária.
        \xTitulo: \xSubtitulo\ / \xAutor\ --- \xCidade: \xUniversidade,
        \xSiglaDaInstituicao, \xAnoDeEntrega.

        \NumeroDeFolhas\,f.

        \xTipoDeTrabalho\ (\MakeUppercase{\xAreaDeConcentracao}) --- \xUniversidade,
        \xSiglaDaInstituicao: \xCidade, \xAnoDeEntrega.

        Orientador(a): \xOrientador.

        Coorientador(a): \xCoorientador.

        \ImprimirPalavrasChaveFicha{brazil}
        I. \xTitulo: \xSubtitulo.

        \Direita CDU \CDU
    \end{indexcard}
}
\def\ImprimirPalavrasChaveFicha#1{\def\tmp{#1}\@tempcnta=1 \doImprimirPalavrasChaveFicha}
\def\doImprimirPalavrasChaveFicha{%
    \ifcsname xPalavraChave\@Alph\@tempcnta/\tmp\endcsname
        \the\@tempcnta.~\csname xPalavraChave\@Alph\@tempcnta/\tmp\endcsname .\space
        \advance\@tempcnta by1
        \expandafter\doImprimirPalavrasChaveFicha
    \else
        \ignorespaces
    \fi
}
\def\ImprimirErrata{
    \nonum\notoc\section{Errata}
    \begingroup
        \ifdefined\fullcite \bibfont\fullcite{ferrigno2011}.\else
            \ClassWarning{abntexto-uece}{"biblatex.sty" ausente.}
        \fi
    \par\endgroup % Esse \par é necessário.
    \Enter
    \Centralizar
    \begin{tabular}{cccc}
        \hline
        \bfseries Folha & \bfseries Linha & \bfseries Onde se lê & \bfseries Leia-se \\ \hline
        16 & 10 & auto-clavado & autoclavado \\ \hline
    \end{tabular}
}
\def\ImprimirFolhaDeAprovacao{
    \Centralizar\xAutor
    \Enter[2]
    \Centralizar
    \begin{minipage}{.7\linewidth}
        \centering\xTitulo
    \end{minipage}
    \Enter[2]
    \Direita
    \begin{minipage}{.5\linewidth}
        \singlesp
        \xDescricaoDoTrabalho
        \Enter
        Área de concentração: \xAreaDeConcentracao.
    \end{minipage}
    \Enter
    {\parindent=1.5cm Aprovado em 00/00/0000.\par}
    \Enter
    \Centralizar BANCA EXAMINADORA
    \Enter
    \ImprimirAvaliadores
}
\def\ImprimirAvaliadores{\@tempcnta=1 \doImprimirAvaliadores}
\def\doImprimirAvaliadores{%
    \ifcsname xAvaliador\@Alph\@tempcnta\endcsname
        \judgeline{\csuse{xAvaliador\@Alph\@tempcnta}}%
        \Enter
        \advance\@tempcnta by1
        \expandafter\doImprimirAvaliadores
    \fi
}
\def\ImprimirDedicatoria{
    \leavevmode\vfill
    \Direita
    \begin{minipage}{\dimexpr\linewidth-8cm}
        \xDedicatoria
    \end{minipage}
}
\def\ImprimirAgradecimentos{
    \nonum\notoc\section{\bfseries Agradecimentos}
    {\parindent=1.5cm\xAgradecimentos\par}
}
\def\ImprimirEpigrafe{
    \leavevmode\vfil
    \Direita
    \begin{minipage}{5cm}
        \noindent \enquote{\xEpigrafe}\\ (autor,~ano)
    \end{minipage}
}
\def\ImprimirResumo#1#2{
    \nonum\notoc {\selectlanguage{#1}\section{\abstractname}}
    \noindent {\selectlanguage{#1}\csname resumo/#1\endcsname\par}
    \Enter
    \noindent \textbf{#2:}~%
    \begingroup \selectlanguage{#1}\nohyph
        \ImprimirPalavrasChave{#1}%
    \par\endgroup
}

\def\ImprimirPalavrasChave#1{%
    \expandafter\expandafter\expandafter \RecortarEsquerda
    \expandafter\@gobble
    \expanded{%
        \expandafter\expandafter\expandafter \ImprimirPalavrasChaveA
        \csname pchave/#1\endcsname ,\relax,%
    }%
}
\def\ImprimirPalavrasChaveA#1,{\if&\RecortarEsquerda#1&\expandafter\ImprimirPalavrasChaveA\else
    \ifx\relax#1.\else
        ;\space \RecortarAmbos{#1}%
        \expandafter\expandafter\expandafter \ImprimirPalavrasChaveA
    \fi\fi
}

\AtBeginDocument{\@ifpackageloaded{babel}{\relax}{\def\selectlanguage#1{}}}

\def\ImprimirPretextual{
    \ImprimirCapa               \newpage
    \ImprimirFolhaDeRosto       \newpage
    \ImprimirFichaCatalografica \newpage
    \ImprimirErrata             \newpage
    \ImprimirFolhaDeAprovacao   \newpage
    \ifdefined\xAgradecimentos \ImprimirAgradecimentos \fi \newpage
    \ifdefined\xDedicatoria    \ImprimirDedicatoria    \fi \newpage
    \ifdefined\xEpigrafe       \ImprimirEpigrafe       \fi \newpage
    \ImprimirResumo{brazil}{Palavras-chave} \newpage
    \ImprimirResumo{english}{Keywords}      \newpage
}
%. \end{code}

% \codesection{Metadados}

% \begin{code}
\def\Metadados{%
    \ifdefined\hypersetup \expandafter\hypersetup \else \expandafter\@gobble \fi
    {
        pdftitle    = \xTitulo,
        pdfauthor   = \xAutor,
        pdfcreator  = LaTeX with abntexto-uece,
        pdfkeywords = \ImprimirPalavrasChave{brazil},
    }%
}
\AtBeginDocument{\Metadados}
%. \end{code}

% \codesection{Ajustes finais}

% Trocando a palavra \enquote{Ilustração} por \enquote{Figura}. Essa redefinição não é necessária se você estiver usando o `abntexto` numa versão igual ou superior a 4.0.4-beta.

% \begin{code}
\definelegendplace{figure}{Figura}{lof}
%. \end{code}

% Indentação deixou de ser 1,5~cm e passou a ser 2~cm. O título das figuras/tabelas deve ser em negrito. \LaTeX\ emite um erro quando `\\` é chamado no modo vertical: o removeremos para que os alertas de `\Mandatorio` sejam destacados no terminal.

% \begin{code}
\parindent=2cm
\appto\targetlegend{\bfseries}
\let\@nolnerr=\relax

\endinput
%. \end{code}