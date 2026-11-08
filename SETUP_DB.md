# Database setup (Supabase, free tier)

The site works without this (emails then stay only in the visitor's browser). To collect for real:

1. Create a project at supabase.com.
2. SQL Editor > paste `supabase.sql` > Run. This creates `subscribers`, `sparks`, `cards`, locks them so
   visitors can only add rows (never read them), and adds `spark_count()` and `register_card()`.
3. Project Settings > API: copy the Project URL and the `anon` public key.
4. In `index.html`, near the top of the script, set `const SB={url:'https://xxxx.supabase.co',key:'eyJ...'}`.
   The anon key is meant to be public; the table rules above are what protect your data. Never use the `service_role` key here.
5. View signups: Supabase > Table Editor > `subscribers`.

What gets stored: newsletter email plus the consent tick; an anonymous random device id with each spark count; an anonymous
device id and spark number for each registered share card (it returns a card number printed on the card).
The child's name typed onto a card is never sent anywhere.

This is a kids' brand: collect emails only from parents and guardians (the sign-up asks for that), add a privacy page, and check
the rules that apply to you (COPPA in the US, GDPR-K in the EU/UK, and India's DPDP Act).
