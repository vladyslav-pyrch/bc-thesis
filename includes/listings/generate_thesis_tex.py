def generate_thesis_tex(
    author,
    reg_nr,
    title,
    title_en,
    day,
    month,
    year,
    keywords,
    keywords_en,
    study_programme,
    study_programme_en,
    study_field,
    study_field_en,
    training_workplace,
    training_workplace_en,
    supervisor,
    consultant=None,
    thesis_type="bp",
    language="sk",
):

    tex_class_option = thesis_type if thesis_type in ["bp", "dp"] else "bp"
    tex_language_option = "en" if language == "en" else ""

    if tex_language_option:
        document_class = f"\\documentclass[{tex_class_option},{tex_language_option}]{{FEIstyle}}"
    else:
        document_class = f"\\documentclass[{tex_class_option}]{{FEIstyle}}"

    tex_content = f"""
{document_class}

% Author of the thesis
\\FEIauthor{{{author}}}

% Evidence number
\\FEIregNr{{{reg_nr}}}

% Title
\\FEItitle{{{title}}}
\\FEItitleEn{{{title_en}}}

% Date
\\FEIdate{{{day}}}{{{month}}}{{{year}}}

% Keywords
\\FEIkeywords{{{keywords}}}
\\FEIkeywordsEn{{{keywords_en}}}

% Further details
\\FEIstudyProgramme{{{study_programme}}}
\\FEIstudyProgrammeEn{{{study_programme_en}}}
\\FEIstudyField{{{study_field}}}
\\FEIstudyFieldEn{{{study_field_en}}}
\\FEItrainingWorkplace{{{training_workplace}}}
\\FEItrainingWorkplaceEn{{{training_workplace_en}}}

% Supervisor
\\FEIsupervisor{{{supervisor}}}
"""

    if consultant:
        tex_content += f"\n\\FEIconsultant{{{consultant}}}\n"

    tex_content += f"""

% Bibliography database file
\\bibliography{{includes/bibliography.bib}}

\\begin{{document}}

\\frontmatter
\\FEIpdfInfo
\\FEIcover
\\FEItitlePage
\\includepdf[pages=-]{{includes/assignment.pdf}}
\\FEIthanks{{includes/thanks}}
\\FEIabstract{{includes/abstract}}
\\FEIabstractEn{{includes/abstractEN}}
\\FEIcontent
\\FEImanualListOfGlossaries{{includes/manual_glossary}}
\\FEIlistOfAlgorithms
\\FEIlistOfListings

\\mainmatter
\\FEIintroduction{{includes/introduction}}
\\FEIcore{{includes/core}}
\\FEIconclusion{{includes/conclusion}}
\\FEIbibliography
\\FEIaiDeclaration{{includes/ai_declaration}}
\\backmatter
\\FEIappendix{{Algoritmus\\label{{att:algorithms}}}}{{includes/attachmentA}}
\\FEIappendix{{Výpis dlhého kódu\\label{{att:listings}}}}{{includes/attachmentB}}
\\FEIappendix{{Slovníček pojmov\\label{{att:dictionary}}}}{{includes/attachmentC}}

\\end{{document}}
"""

    with open("thesis.tex", "w", encoding="utf-8") as file:
        file.write(tex_content)

    print("Súbor thesis.tex bol úspešne vygenerovaný.")


# Testovacie volanie funkcie
generate_thesis_tex(
    author="Vladyslav Pyrch",
    reg_nr="FEI-xxxx-xxxx",
    title="Riešenie vybraných kombinatorických úloh pomocou nástroja SAT Solver",
    title_en="ESolving selected combinatorial problems using the SAT Solver tool",
    day="30",
    month="6",
    year="2026",
    keywords="TBA",
    keywords_en="TBA",
    study_programme="Aplikovaná informatika",
    study_programme_en="Applied Informatics",
    study_field="Bezpečnosť pocitačových systémov",
    study_field_en="Security of Information Technologies",
    training_workplace="Ústav informatiky a matematiky",
    training_workplace_en="Institute of Computer Science and Mathematics",
    supervisor="RNDr. Martin Nehéz, PhD.",
    consultant="",
    thesis_type="bp",  # Možnosti: "bp", "dp"
    language="en",  # Možnosti: "sk" (slovenčina - predvolená), "en" (angličtina)
)
