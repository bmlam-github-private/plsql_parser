CREATE OR REPLACE TYPE Breadcrumb AS OBJECT (
  -- Attributes to hold tracking data
  object_id   NUMBER,
  created_at  TIMESTAMP,
  
  -- User-defined Constructor
  CONSTRUCTOR FUNCTION Breadcrumb(SELF IN OUT NOCOPY Breadcrumb) RETURN SELF AS RESULT,
  
  -- Destructor mimic
  MEMBER PROCEDURE destroy(SELF IN OUT NOCOPY Breadcrumb)
);
/