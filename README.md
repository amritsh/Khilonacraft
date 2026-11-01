# Khilona Craft landing page

Static site: `index.html` + `assets/`. No build step.

## Host on GitHub Pages
1. Create a repo and push these files to the `main` branch (keep `assets/` and `.nojekyll`).
2. Settings > Pages > Source: `main` / root. Your site appears at `https://<user>.github.io/<repo>/`.

## Newsletter emails
By default the popup saves emails only in the visitor's own browser (so nothing is collected yet).
To really collect them, make a free form endpoint (Formspree, Getform, etc.) and paste its URL into
`const ENDPOINT=''` near the bottom of `index.html`.

## Edit
Builder profiles are the `B` array in the script. Product pieces are the `pcs` array.
