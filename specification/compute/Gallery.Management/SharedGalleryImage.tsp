import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SharedGallery.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the gallery image definition that you want to create or update.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@parentResource(SharedGallery)
model SharedGalleryImage is ProxyResourceShared<SharedGalleryImageProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGalleryImage,
    KeyName = "galleryImageName",
    SegmentName = "images",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SharedGalleryImages {
  /**
   * Get a shared gallery image by subscription id or tenant id.
   */
  get is ComputeResourceRead<SharedGalleryImage>;

  /**
   * List shared gallery images by subscription id or tenant id.
   */
  list is Azure.ResourceManager.Legacy.ComputeLegacyOperations.ArmResourceListByParent<
    SharedGalleryImage,
    Parameters = {
      /**
       * The query parameter to decide what shared galleries to fetch when doing listing operations.
       */
      @query("sharedTo")
      sharedTo?: SharedToValues;
    },
    Response = SharedGalleryImageList
  >;
}

@@doc(SharedGalleryImage.name,
  "The name of the Shared Gallery Image Definition from which the Image Versions are to be listed."
);
@@doc(SharedGalleryImage.properties,
  "Describes the properties of a gallery image definition."
);
