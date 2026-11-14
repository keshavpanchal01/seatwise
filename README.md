# Seatwise — NEET PG Institute Information Website

Ready-to-upload GitHub Pages website package.

## Files Included
- `index.html` — Complete website application (Home, Premium, Contact, and Policy pages)
- `config.js` — Public configuration settings (Google Client ID, Contact Email, and optional Backend API URL)
- `all.csv` — NEET PG institute dataset (2,658 records)
- `DEPLOYMENT.md` — Step-by-step guide for optional Cloudflare Worker + Razorpay backend setup
- `README.md` — Quick deployment instructions

---

## How to Publish on GitHub Pages (No Coding Required)

1. **Upload Files to GitHub**
   - Open your GitHub repository.
   - Click **Add file → Upload files**.
   - Extract this ZIP file and drag `index.html`, `config.js`, `all.csv`, `DEPLOYMENT.md`, and `README.md` directly into the top level (root) of your repository.
   - Click **Commit changes**.

2. **Enable GitHub Pages**
   - Go to your repository **Settings → Pages**.
   - Under **Build and deployment → Source**, select **Deploy from a branch**.
   - Choose branch **`main`** and folder **`/ (root)`**, then click **Save**.
   - Your website will be live in 1–2 minutes at `https://<your-username>.github.io/<repository-name>/`.

3. **Authorize Google Sign-In for Your Live URL**
   - Open [Google Cloud Console → APIs & Services → Credentials](https://console.cloud.google.com/apis/credentials).
   - Open your OAuth 2.0 Client ID (`437007721003-6fdslfcbpqed1p2uuits01g1jorks53k.apps.googleusercontent.com`).
   - Under **Authorized JavaScript origins**, click **+ ADD URI** and enter your GitHub Pages origin:
     `https://<your-username>.github.io` *(do not include the repository path or a trailing slash)*.
   - Click **Save** (changes take up to 5 minutes to propagate).

4. **Updating Institute Data Later**
   - Whenever you have updated NEET PG data, replace `all.csv` in your GitHub repository with the new file of the exact same name (`all.csv`). The website automatically fetches the latest copy on every page load.
