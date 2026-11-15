# Seatwise – Premium payments: setup (Cloudflare Pages)

Your site stays on Cloudflare Pages. The new files add a small secure server part (`functions/` and `lib/`) that Cloudflare runs for you automatically. Nothing to install, no terminal.

**Important:** your Pages project must be connected to your GitHub repository (that is how it already updates when you upload). If you ever used "Direct upload / drag and drop" instead, server files will NOT work; tell me and I will give you the alternative.

## Step 0 – Razorpay keys (do this first)
Your Key Secret was pasted in an earlier chat, so treat it as exposed. In Razorpay: Account & Settings → API Keys → **Regenerate Live Key**. Keep the new **Key ID** (starts `rzp_live_`) and new **Key Secret** open in a notepad. Never paste the Key Secret in any chat or on GitHub.

## Step 1 – Upload to GitHub
1. Unzip `seatwise-project.zip` on your computer.
2. GitHub → your repository → **Add file → Upload files**.
3. Drag in EVERYTHING inside the unzipped folder, keeping folders: `index.html`, `config.js`, `all.csv`, `schema.sql`, `_headers`, and the folders `functions` and `lib` (and `tests`, optional). Easiest: drag the folders themselves.
4. Commit changes. Cloudflare will start a build automatically (it may show an error about missing settings until Steps 2–4 are done; that is expected).

## Step 2 – Create the database (Cloudflare dashboard)
1. dash.cloudflare.com → **Storage & Databases → D1 SQL Database → Create database**. Name: `seatwise-db`. Create.
2. Open it → **Console** tab → open the file `schema.sql` from the ZIP in Notepad, copy ALL of it, paste into the console box, click **Execute**. You should see the 4 tables created.

## Step 3 – Connect the database to your site
Workers & Pages → your Pages project (`seatwise-u4d`) → **Settings → Bindings → Add → D1 database**
- Variable name: `DB` (exactly, capital letters)
- D1 database: `seatwise-db`
Save (Production).

## Step 4 – Paste the settings
Same project → **Settings → Variables and Secrets → Add** (Production). Add these five:

| Name | Type | Value |
|---|---|---|
| `GOOGLE_CLIENT_ID` | Text | `437007721003-i8csj3qirbjbgp7d0kjfiso3mevi70q2.apps.googleusercontent.com` |
| `RAZORPAY_KEY_ID` | Text | your LIVE Key ID `rzp_live_...` |
| `RAZORPAY_KEY_SECRET` | **Secret** | your LIVE Key Secret |
| `SESSION_SECRET` | **Secret** | any long random text, 48+ characters (mash the keyboard). Keep it private. |
| `RAZORPAY_WEBHOOK_SECRET` | **Secret** | any long random text (you will paste the SAME text into Razorpay in Step 5) |

Choose type **Secret** (not Text) for the three marked Secret.

## Step 5 – Razorpay webhook
Razorpay Dashboard → Account & Settings → **Webhooks → Add New Webhook** (make sure you are in **Live** mode)
- Webhook URL: `https://seatwise-u4d.pages.dev/api/webhook`
- Secret: the same text as `RAZORPAY_WEBHOOK_SECRET`
- Active events: tick **payment.captured** and **order.paid**
Save.

## Step 6 – Redeploy
Cloudflare Pages project → **Deployments** → latest → **Retry deployment** (settings only apply to new deployments).

## Step 7 – Check it
1. Open `https://seatwise-u4d.pages.dev/api/` – you must see `"configured":true`. If it lists names under `missing`, add those settings and redo Step 6.
2. Real test (one time): open the site → click a locked row → Google sign-in → username → the Razorpay window opens automatically → pay ₹10 → the green ✓ appears. Sign out, sign in again: ✓ is back, no payment asked. Refund yourself from the Razorpay dashboard if you want the ₹10 back.

## Recommended extra protection (2 minutes, free)
Cloudflare dashboard → your domain/Pages → **Security → WAF → Rate limiting rules → Create**: if URI Path starts with `/api/`, limit 30 requests per 1 minute per IP, action Block. (The code has its own limits too, but this one covers all visitors together.)

## Daily data updates
Unchanged: replace `all.csv` in GitHub.

## Where is the data?
D1 database `seatwise-db`: tables `users` (premium yes/no), `orders`, `payments` (payment IDs), `audit` (events, no secrets). View them in the D1 Console, e.g. `SELECT * FROM audit ORDER BY id DESC LIMIT 20;`. If the audit shows `extra_payment_needs_refund`, someone paid twice; refund that payment in Razorpay.
