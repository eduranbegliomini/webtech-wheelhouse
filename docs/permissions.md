# Permissions

## Repairs
| Action | Owner | Counter | Mechanic |
| :--- | :--- | :--- | :--- |
| Read (Index/Show) | Every repair | Every repair | Only the repairs assigned to them |
| Create (Take in) | Yes | Yes | No |
| Edit | Every repair | Every repair not handed back | Their own repairs, not handed back |
| Delete | Yes | No | No |

## Customers & Bikes
| Action | Owner | Counter | Mechanic |
| :--- | :--- | :--- | :--- |
| Read (Index/Show) | Yes | Yes | No access |
| Create / Edit | Yes | Yes | No access |
| Delete | Yes | Yes | No access |

## Services & Staff
| Action | Owner | Counter | Mechanic |
| :--- | :--- | :--- | :--- |
| Read (Index/Show) | Yes | Yes | Yes |
| Create / Edit | Yes | Yes | No |
| Delete | Yes | Yes | No |