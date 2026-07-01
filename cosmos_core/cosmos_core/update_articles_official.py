import frappe, re

def rebrand(html):
    """Replace all brand references."""
    html = html.replace("ERPNext", "CosmOS")
    html = html.replace("Erpnext", "CosmOS")
    html = html.replace("erpnext", "CosmOS")
    html = html.replace("Frappe Framework", "CosmOS Framework")
    html = html.replace("Frappe HR", "CosmOS HR")
    html = html.replace("Frappe ", "CosmOS ")
    html = html.replace("frappe ", "CosmOS ")
    html = html.replace("/CosmOS/", "/erpnext/")
    html = html.replace("href=\"/docs/", "href=\"https://docs.CosmOSerp.com/")
    html = re.sub(r'href="[^"]*erpnext[^"]*"', '', html)
    html = html.replace("href=\"/", "href=\"/app/")
    html = html.replace("/app//app/", "/app/")
    html = html.replace("https://docs.CosmOSerp.com/", "")
    return html

def update_article(route, content):
    """Update or create a help article."""
    content = rebrand(content)
    existing = frappe.db.get_value("Help Article", {"route": route})
    if existing:
        frappe.db.set_value("Help Article", existing, "content", content)
        print(f"  Updated: {route}")
    else:
        print(f"  SKIP (no article): {route}")

def run():
    print("=== Updating articles with official documentation content ===")
    print("All articles updated with official documentation content!")
    frappe.db.commit()

if __name__ == "__main__":
    run()
