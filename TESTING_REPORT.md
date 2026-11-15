# Test & security report (payments)

## Run
`node --no-warnings tests/backend.test.mjs` → 61 checks. Google, Razorpay and the database are SIMULATED (a real SQL engine is used for the database). **No live payment was made; I cannot access your Razorpay, Google or Cloudflare accounts.** Do the one real ₹10 test in DEPLOYMENT.md Step 7.

## Verified by tests
Google ID token checked on the server (signature, issuer, audience, expiry, verified email); forged/expired/wrong-audience rejected. Signed sessions; tampered or forged sessions rejected. Price fixed at ₹10 INR on the server (browser values ignored). Forged or wrong-secret signatures rejected; failed, wrong-amount and other-order payments rejected; every payment is re-confirmed with Razorpay. Another user cannot claim someone's order. A payment can only unlock the account that owns the order. Retry after failure/cancel reuses the same order (no duplicate order/charge); paid users are never asked again. Webhook: bad/missing signature rejected, replay harmless, unknown order ignored, grants premium if the browser never confirmed. Missed webhook + closed tab is recovered on next load. Duplicate payment is flagged for refund. SQL-injection username rejected (all queries are parameterised). Foreign Origin blocked, oversized/invalid bodies rejected, rate limits work, no secret appears in any response or audit log.

## Security measures
Secrets only in Cloudflare Secrets; Key ID is public by design. No cookies (Bearer token), so no CSRF; Origin check as extra. Premium status is read only from the database; localStorage is never trusted. All output is escaped by the existing site code. HTTPS + security headers via `_headers` (no CSP added, to avoid breaking Google/Razorpay scripts).

## Honest limits
- Not tested live (see above). - In-code rate limiting is per server instance; add the Cloudflare WAF rule for a strong limit. - Sessions last 14 days and cannot be revoked individually (rotate `SESSION_SECRET` to sign everyone out). - Not a formal third-party penetration test.

## Changed in your site
`index.html`: one line (after the username is saved, checkout opens automatically). `config.js`: `API_BASE` set to `/api`. Nothing else. New: `functions/`, `lib/`, `schema.sql`, `_headers`, `tests/`.
