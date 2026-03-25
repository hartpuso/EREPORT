DO $$
DECLARE constraint_name text;
BEGIN
    SELECT conname INTO constraint_name
    FROM pg_constraint
    WHERE conrelid = 'public.user_profiles'::regclass AND contype = 'c';
    
    IF constraint_name IS NOT NULL THEN
        EXECUTE 'ALTER TABLE public.user_profiles DROP CONSTRAINT ' || constraint_name;
    END IF;
END $$;

ALTER TABLE public.user_profiles ADD CONSTRAINT profiles_role_check CHECK (role IN ('admin', 'employee', 'hr'));
