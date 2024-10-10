# AzureKey_Vault
**Provisioning a key vault with private end point access to store secrets.**

# Scenario
A virtual machine that is currently in use and is running many automation scripts in an IT environment. Unfortunately, there is a chance that the scripts embedded with credentials will cause a security breach. As a result, it is our responsibility to keep the script safe from users who weren't permitted to retrieve the credentials.

To store the credentials in a safe location, we will need a few more resources. Therefore, we also provide a Key Vault for storing secrets and a user-assigned managed identity to authenticate to Key Vault.

**High Level Architecture Diagram**

[Uploading VMKeyVau<mxfile host="Electron" agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) draw.io/24.7.8 Chrome/128.0.6613.36 Electron/32.0.1 Safari/537.36" version="24.7.8">
  <diagram id="Jod9YqByfM_39vSJtJOT" name="Page-1">
    <mxGraphModel dx="794" dy="511" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="850" pageHeight="1100" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="SYUifTDxzM4DdVmVaASi-6" value="" style="whiteSpace=wrap;html=1;" vertex="1" parent="1">
          <mxGeometry x="130.5" y="154" width="520" height="260" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-1" value="" style="image;aspect=fixed;html=1;points=[];align=center;fontSize=12;image=img/lib/azure2/compute/Virtual_Machine.svg;" vertex="1" parent="1">
          <mxGeometry x="356.5" y="252" width="69" height="64" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-2" value="" style="image;aspect=fixed;html=1;points=[];align=center;fontSize=12;image=img/lib/azure2/general/Resource_Groups.svg;" vertex="1" parent="1">
          <mxGeometry x="620" y="380" width="57.38" height="54" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-3" value="" style="image;sketch=0;aspect=fixed;html=1;points=[];align=center;fontSize=12;image=img/lib/mscae/Key_Vaults.svg;" vertex="1" parent="1">
          <mxGeometry x="540" y="257" width="48" height="50" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-4" value="" style="image;sketch=0;aspect=fixed;html=1;points=[];align=center;fontSize=12;image=img/lib/mscae/Managed_Identities.svg;" vertex="1" parent="1">
          <mxGeometry x="200" y="257" width="38" height="50" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-5" value="" style="image;aspect=fixed;html=1;points=[];align=center;fontSize=12;image=img/lib/azure2/identity/Azure_Active_Directory.svg;" vertex="1" parent="1">
          <mxGeometry x="355.5" y="40" width="70" height="64" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-8" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.502;entryY=1;entryDx=0;entryDy=0;entryPerimeter=0;dashed=1;" edge="1" parent="1" source="SYUifTDxzM4DdVmVaASi-1" target="SYUifTDxzM4DdVmVaASi-5">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-11" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.022;entryY=0.479;entryDx=0;entryDy=0;entryPerimeter=0;dashed=1;" edge="1" parent="1" source="SYUifTDxzM4DdVmVaASi-4" target="SYUifTDxzM4DdVmVaASi-1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-13" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.208;entryY=0.54;entryDx=0;entryDy=0;entryPerimeter=0;" edge="1" parent="1" source="SYUifTDxzM4DdVmVaASi-1" target="SYUifTDxzM4DdVmVaASi-3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-14" value="Managed Identity" style="text;strokeColor=none;align=center;fillColor=none;html=1;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="178" y="316" width="60" height="30" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-15" value="Assign" style="text;strokeColor=none;align=center;fillColor=none;html=1;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="260" y="286" width="60" height="30" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-18" value="Access" style="text;strokeColor=none;align=center;fillColor=none;html=1;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="450" y="286" width="60" height="30" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-19" value="" style="image;aspect=fixed;html=1;points=[];align=center;fontSize=12;image=img/lib/azure2/networking/Private_Link.svg;" vertex="1" parent="1">
          <mxGeometry x="459.82" y="316" width="50.18" height="46" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-20" value="Via Private Link" style="text;strokeColor=none;align=center;fillColor=none;html=1;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="454.91" y="370" width="60" height="30" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-21" value="Azure AD" style="text;strokeColor=none;align=center;fillColor=none;html=1;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="330" y="110" width="60" height="30" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-16" value="Authenticate" style="text;strokeColor=none;align=center;fillColor=none;html=1;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="360.5" y="180" width="60" height="30" as="geometry" />
        </mxCell>
        <mxCell id="SYUifTDxzM4DdVmVaASi-23" value="" style="verticalLabelPosition=bottom;html=1;verticalAlign=top;align=center;strokeColor=none;fillColor=#00BEF2;shape=mxgraph.azure.powershell_file;pointerEvents=1;" vertex="1" parent="1">
          <mxGeometry x="400" y="230" width="40" height="40" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
ltSecrets.drawio…]()
