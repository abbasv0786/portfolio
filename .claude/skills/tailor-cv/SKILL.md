---
name: tailor-cv
description: Tailor the portfolio's profile summary, experience, projects and skills to a job description. Takes a JSON file exported from Admin > Projects > Export plus a job description, and writes a tailored copy to import back. Use when the user wants to tailor, customise or target their CV or portfolio for a job, role, company or job description, or runs /tailor-cv.
argument-hint: "[path to exported cv-data JSON] [job description text, file or URL]"
---

# Tailor CV to a job description

The portfolio site and the downloadable CV are both built from the same Firestore data. The admin panel exports the profile headline and summary, experience entries, projects and skill categories as JSON (`Export` on the Projects, Experience or Skills tab). This skill rewrites that file for one job; the user imports it back (`Admin > Projects > Import`), previews the changes, and applies them.

If the user says not to remove existing work, don't set any project to `"isActive": false` and don't drop any skills or bullets: reorder and reword only.

## 1. Gather the two inputs

- **Exported data:** use the path in the arguments. Otherwise take the newest `~/Downloads/cv-data-*.json` (`ls -t ~/Downloads/cv-data-*.json | head -1`) and tell the user which file you picked. Check that `"format"` is `"portfolio-cv-data"`. If there's no file, tell them to export one first and stop.
- **Job description:** pasted text, a file path, or a URL (fetch it). If none was given, ask for it.

Read both in full before changing anything.

## 2. What the output feeds (so the edits land)

- **CV:** shows the switched-on projects in `order` (lowest first), **only the first 4**, and **only the first sentence** of each `description` (text up to the first `.`). The skill categories print in `order` as `Title: skill, skill, ...`; a category with an empty `skills` list is left off the CV.
- **CV header and summary:** `profile.title` is the headline under the name, and the summary paragraph is `profile.subtitle` + `profile.description` joined. `profile.tagline` and `profile.typingWords` only appear on the website hero.
- **CV experience:** every experience in `order` (lowest first), with **every** `- ` bullet line of its `description` printed.
- **Portfolio site:** shows every switched-on project with its full description, and every skill category, empty ones included.

## 3. Tailor: rules

**Truthfulness comes first.** Only reword, reorder, select and emphasise what's already in the file. Never invent projects, employers, numbers, technologies or results. A skill may be added only if the same file already shows it (for example in a project's `technologies`). If the job asks for something the data doesn't support, list it as a gap in the report; don't add it.

Profile:
- Rewrite `title`, `subtitle` and `description` so the summary leads with what this job wants, using only claims the file supports. You may reorder `typingWords` and reword them for the job, but don't invent roles.

Experience:
- Never change `id`, `company`, `duration` or `companyUrl`. Never delete an experience; keep every entry.
- Reorder and reword the `- ` bullets so the job-relevant ones come first, using the job's vocabulary. Don't add duties or results the original bullets don't state. Keep one bullet per line, each starting with `- `.
- Leave `order` alone (the CV lists roles chronologically) unless the user asks.
- Reorder `technologies` so the job-relevant ones come first.

Projects:
- Rank every project by relevance to the job. Give the best ones the lowest `order` values (0, 1, 2, ...), so the top 4 are the strongest match.
- Set `"isActive": false` on projects that would weaken this application. Keep at least 3 switched on, and don't switch off a project just because the job doesn't mention its technologies.
- Rewrite the `description` so its **first sentence** is a self-contained pitch built from the job's own keywords and the project's real result. The sentences after it can keep the fuller detail for the website. Don't use `.` inside that first sentence (write "Node" rather than "Node.js", "v2" rather than "v2.0"), because it marks where the CV cuts the text.
- Reorder `technologies` so the job-relevant ones come first. Keep the original entries.
- Never change `id`. Leave `liveUrl`, `androidUrl`, `iOSUrl` and `category` as they are unless asked.

Skills:
- Reorder categories by relevance (`order`), and reorder the skills inside each one so the job's keywords come first, using the job's spelling where it's the same skill ("Postgres" → "PostgreSQL").
- You may drop clearly irrelevant skills from a category to keep the CV focused. Don't empty a category: the site would show an empty card. Import never deletes categories.
- Never change `id` or `color`.

Keep `format`, `version` and the top-level structure. Set `exportedAt` to now.

## 4. Write the tailored file

Write it next to the source as `cv-data-<company-or-role-slug>-<YYYY-MM-DD>.json`. **Never overwrite the source export**: it's the user's backup and their way back to the main version. Check that it parses (`python3 -m json.tool <file> > /dev/null`).

## 5. Report back (short)

- The output file path.
- The 4 projects the CV will now show, in order, and which projects were switched off.
- A few of the job's keywords that are now covered.
- **Gaps:** requirements the data doesn't back up, so the user can decide whether to add real material in the admin panel.
- How to apply it: Admin → Projects (or Experience/Skills) → **Import** → choose the file → review → Apply. Remind them that this also changes the public portfolio, and that importing the original export file restores the main version.
