import frappe

def create_category(name, desc):
    if not frappe.db.exists("Help Category", name):
        cat = frappe.get_doc({"doctype": "Help Category", "category_name": name, "category_description": desc})
        cat.insert(ignore_permissions=True)
        print(f"  Created Category: {name}")

def upsert_article(title, category, content, route=None):
    if not route:
        route = title.lower().replace(" ", "-").replace("&", "and")
    route = route.replace("--", "-")
    existing = frappe.db.get_value("Help Article", {"route": route})
    if existing:
        frappe.db.set_value("Help Article", existing, "content", content)
        frappe.db.set_value("Help Article", existing, "category", category)
        print(f"  Updated Article: {title}")
    else:
        doc = frappe.get_doc({
            "doctype": "Help Article",
            "title": title,
            "route": route,
            "category": category,
            "content": content,
            "published": 1,
            "author": "CosmOS"
        })
        doc.insert(ignore_permissions=True)
        print(f"  Created Article: {title}")

def build():
    print("=== Building CosmOS Knowledge Base ===")
    print("Categories done.")

if __name__ == "__main__":
    build()
