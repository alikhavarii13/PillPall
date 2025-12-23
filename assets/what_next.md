# Next Actions

Below are the most important tasks to tackle next, ordered by impact.

1. **Fix token persistence and refresh flow**

   - Ensure `TokenNotifier.saveTokens` completes before navigation and reload tokens on app start so sessions survive restarts.
   - Attach auth headers in `dioProvider`, add refresh-token handling, and redirect to sign-in on expiry.

2. **Harden pill add/edit UX and validation**

   - Require dropdown selections, guard numeric fields, and block submission until the form is valid.
   - Prefill fields when editing and add date/time pickers for "last taken" to avoid invalid values.

3. **Improve local/cloud sync reliability**

   - Prevent duplicate inserts when merging remote pills, propagate deletes/updates to Supabase, and track sync status or timestamps for conflict resolution.
   - Add error handling and retries around network operations and queue offline changes.

4. **Surface user feedback and resiliency**

   - Add loading/error states for pill CRUD operations, confirm deletions, and surface failures via snackbars or inline banners.
   - Provide settings to manage notification permissions and to cancel/reschedule reminders.

5. **Add quality gates**
   - Write unit/widget tests for auth flows, reminder calculations, and repository sync; mock Dio and sqflite layers to cover edge cases.
   - Expand README with environment setup (Supabase keys, notification permissions) to streamline onboarding.
