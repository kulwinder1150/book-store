import {Head} from '@inertiajs/react';
import {PageProps} from '@/types';
import Listing from "@/Pages/Listing";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout";

export default function Welcome({auth, ...rest}: PageProps<any>) {
    return (
        <>
            <AuthenticatedLayout
                user={auth.user}
                {...rest}
            >
                <Head title="Home"/>

                <div className="py-12">
                    <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                        <div className="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                            <main className={'p-5 main-listing-section'}>
                                <h1 className={'text-4xl font-bold mb-3'}>Books at Amazon</h1>
                                <p className={'mb-4 text-[#6b7080]'}>Checkout out the latest release</p>
                                <hr className={'border-[#e5e7eb]'}/>
                                <Listing/>
                            </main>
                        </div>
                    </div>
                </div>
            </AuthenticatedLayout>
        </>
    );
}
